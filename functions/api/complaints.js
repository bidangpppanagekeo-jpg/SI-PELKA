const GOOGLE_TOKEN_URL = 'https://oauth2.googleapis.com/token';
const GOOGLE_SHEETS_SCOPE =
  'https://www.googleapis.com/auth/spreadsheets';
const MAX_BODY_BYTES = 20_000;

const incidentTypes = new Set([
  'Fisik',
  'Psikologis',
  'Seksual',
  'Penelantaran',
  'Lainnya',
]);
const reporterRelationships = new Set([
  'Korban',
  'Keluarga',
  'Saksi',
  'Pendamping',
  'Lainnya',
]);
const perpetratorRelationships = new Set([
  'Keluarga',
  'Pasangan',
  'Teman',
  'Tetangga',
  'Rekan kerja',
  'Orang tidak dikenal',
  'Lainnya',
]);

function jsonResponse(body, status, origin) {
  const headers = new Headers({
    'Content-Type': 'application/json; charset=utf-8',
    'Cache-Control': 'no-store',
    'X-Content-Type-Options': 'nosniff',
  });
  if (origin) {
    headers.set('Access-Control-Allow-Origin', origin);
    headers.set('Vary', 'Origin');
  }
  return new Response(JSON.stringify(body), { status, headers });
}

function encodeBase64Url(bytes) {
  let binary = '';
  for (const byte of bytes) binary += String.fromCharCode(byte);
  return btoa(binary).replaceAll('+', '-').replaceAll('/', '_').replace(/=+$/, '');
}

function encodeJsonBase64Url(value) {
  return encodeBase64Url(new TextEncoder().encode(JSON.stringify(value)));
}

function readPem(privateKey) {
  const base64 = privateKey
    .replace('-----BEGIN PRIVATE KEY-----', '')
    .replace('-----END PRIVATE KEY-----', '')
    .replace(/\s/g, '');
  const binary = atob(base64);
  return Uint8Array.from(binary, (character) => character.charCodeAt(0));
}

async function createGoogleAccessToken(serviceAccount) {
  const now = Math.floor(Date.now() / 1000);
  const header = encodeJsonBase64Url({ alg: 'RS256', typ: 'JWT' });
  const claim = encodeJsonBase64Url({
    iss: serviceAccount.client_email,
    scope: GOOGLE_SHEETS_SCOPE,
    aud: GOOGLE_TOKEN_URL,
    iat: now,
    exp: now + 3600,
  });
  const unsignedToken = `${header}.${claim}`;
  const key = await crypto.subtle.importKey(
    'pkcs8',
    readPem(serviceAccount.private_key),
    { name: 'RSASSA-PKCS1-v1_5', hash: 'SHA-256' },
    false,
    ['sign'],
  );
  const signature = await crypto.subtle.sign(
    'RSASSA-PKCS1-v1_5',
    key,
    new TextEncoder().encode(unsignedToken),
  );
  const assertion = `${unsignedToken}.${encodeBase64Url(new Uint8Array(signature))}`;
  const response = await fetch(GOOGLE_TOKEN_URL, {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({
      grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
      assertion,
    }),
  });
  if (!response.ok) {
    console.error('Google OAuth token request failed:', response.status);
    throw new Error('Google authentication failed');
  }
  const token = await response.json();
  if (typeof token.access_token !== 'string') {
    console.error('Google OAuth response did not contain an access token');
    throw new Error('Google authentication failed');
  }
  return token.access_token;
}

function requiredText(value, maxLength) {
  return typeof value === 'string' &&
    value.trim().length > 0 &&
    value.length <= maxLength;
}

function validateComplaint(value) {
  if (value === null || typeof value !== 'object' || Array.isArray(value)) {
    return 'Format pengaduan tidak valid.';
  }
  const requiredFields = [
    ['reporterName', 150],
    ['reporterRelationship', 80],
    ['reporterPhone', 30],
    ['victimName', 150],
    ['victimDistrict', 150],
    ['victimSubdistrict', 150],
    ['victimVillage', 150],
    ['perpetratorNameStatus', 30],
    ['incidentType', 40],
    ['story', 1500],
  ];
  for (const [field, maxLength] of requiredFields) {
    if (!requiredText(value[field], maxLength)) {
      return 'Lengkapi semua data wajib dengan format yang benar.';
    }
  }
  if (!/^[0-9+().\-\s]{9,30}$/.test(value.reporterPhone)) {
    return 'Nomor kontak pelapor tidak valid.';
  }
  if (!reporterRelationships.has(value.reporterRelationship)) {
    return 'Hubungan pelapor dengan korban tidak valid.';
  }
  if (
    !Number.isInteger(value.victimAge) ||
    value.victimAge < 0 ||
    value.victimAge > 120
  ) {
    return 'Usia korban tidak valid.';
  }
  if (
    value.perpetratorNameStatus !== 'Diketahui' &&
    value.perpetratorNameStatus !== 'Tidak diketahui'
  ) {
    return 'Status nama pelaku tidak valid.';
  }
  if (
    value.perpetratorAge !== null &&
    value.perpetratorAge !== '' &&
    (!Number.isInteger(value.perpetratorAge) ||
      value.perpetratorAge < 0 ||
      value.perpetratorAge > 120)
  ) {
    return 'Usia pelaku tidak valid.';
  }
  if (!incidentTypes.has(value.incidentType)) {
    return 'Jenis kejadian tidak valid.';
  }
  if (
    value.perpetratorRelationship != null &&
    value.perpetratorRelationship !== '' &&
    !perpetratorRelationships.has(value.perpetratorRelationship)
  ) {
    return 'Hubungan pelaku dengan korban tidak valid.';
  }
  if (value.safeToContact !== true || value.privacyConsent !== true) {
    return 'Persetujuan pengiriman pengaduan belum diberikan.';
  }
  return null;
}

export async function onRequestPost({ request, env }) {
  const origin = request.headers.get('Origin');
  if (!env.ALLOWED_ORIGIN || origin !== env.ALLOWED_ORIGIN) {
    return jsonResponse({ error: 'Asal permintaan tidak diizinkan.' }, 403);
  }
  if (!request.headers.get('Content-Type')?.startsWith('application/json')) {
    return jsonResponse({ error: 'Format permintaan tidak didukung.' }, 415, origin);
  }
  const body = await request.text();
  if (new TextEncoder().encode(body).byteLength > MAX_BODY_BYTES) {
    return jsonResponse({ error: 'Ukuran pengaduan terlalu besar.' }, 413, origin);
  }
  let complaint;
  try {
    complaint = JSON.parse(body);
  } catch (error) {
    if (error instanceof SyntaxError) {
      return jsonResponse({ error: 'Format pengaduan tidak valid.' }, 400, origin);
    }
    throw error;
  }
  const validationError = validateComplaint(complaint);
  if (validationError) {
    return jsonResponse({ error: validationError }, 400, origin);
  }

  let serviceAccount;
  try {
    serviceAccount = JSON.parse(env.GOOGLE_SERVICE_ACCOUNT_JSON ?? '');
  } catch (error) {
    if (error instanceof SyntaxError) {
      console.error('Google service account secret is not valid JSON');
      return jsonResponse(
        { error: 'Layanan penyimpanan belum dikonfigurasi.' },
        503,
        origin,
      );
    }
    throw error;
  }
  if (
    serviceAccount === null ||
    typeof serviceAccount !== 'object' ||
    !env.GOOGLE_SHEETS_SPREADSHEET_ID ||
    !env.GOOGLE_SHEETS_TAB ||
    typeof serviceAccount.client_email !== 'string' ||
    typeof serviceAccount.private_key !== 'string' ||
    !serviceAccount.client_email ||
    !serviceAccount.private_key
  ) {
    console.error('Google Sheets configuration is incomplete');
    return jsonResponse(
      { error: 'Layanan penyimpanan belum dikonfigurasi.' },
      503,
      origin,
    );
  }

  try {
    const accessToken = await createGoogleAccessToken(serviceAccount);
    const range = `${env.GOOGLE_SHEETS_TAB}!A:R`;
    const sheetUrl = new URL(
      `https://sheets.googleapis.com/v4/spreadsheets/${encodeURIComponent(env.GOOGLE_SHEETS_SPREADSHEET_ID)}/values/${encodeURIComponent(range)}:append`,
    );
    sheetUrl.searchParams.set('valueInputOption', 'RAW');
    sheetUrl.searchParams.set('insertDataOption', 'INSERT_ROWS');

    const response = await fetch(sheetUrl, {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${accessToken}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        values: [[
          new Date().toISOString(),
          complaint.reporterName.trim(),
          complaint.reporterRelationship,
          complaint.reporterPhone.trim(),
          complaint.victimName.trim(),
          complaint.victimAge,
          complaint.victimDistrict.trim(),
          complaint.victimSubdistrict.trim(),
          complaint.victimVillage.trim(),
          complaint.perpetratorNameStatus,
          complaint.perpetratorName?.trim() ?? '',
          complaint.perpetratorAge ?? '',
          complaint.perpetratorAddress?.trim() ?? '',
          complaint.perpetratorRelationship ?? '',
          complaint.incidentType,
          complaint.story.trim(),
          complaint.safeToContact,
          complaint.privacyConsent,
        ]],
      }),
    });
    if (!response.ok) {
      console.error('Google Sheets append failed:', response.status);
      return jsonResponse(
        {
          error:
            'Status penyimpanan belum dapat dipastikan. Hubungi petugas layanan sebelum mencoba lagi.',
        },
        502,
        origin,
      );
    }
    return jsonResponse({ saved: true }, 201, origin);
  } catch (error) {
    console.error('Google Sheets submission failed:', error);
    return jsonResponse(
      {
        error:
          'Status penyimpanan belum dapat dipastikan. Hubungi petugas layanan sebelum mencoba lagi.',
      },
      502,
      origin,
    );
  }
}
