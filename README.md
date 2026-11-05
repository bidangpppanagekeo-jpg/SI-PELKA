# Ruang Aman — Perempuan & Anak

MVP Flutter berbahasa Indonesia untuk prototipe informasi dan alur pengaduan.

## Menjalankan

Pastikan Flutter SDK tersedia. Buat berkas platform yang dibutuhkan dari folder proyek, lalu ambil dependensi dan jalankan:

```shell
flutter create --platforms=web,android,ios .
flutter pub get
flutter run
```

Jalankan tes widget dengan `flutter test`.

## Publikasi ke Cloudflare Pages

Workflow GitHub Actions di `.github/workflows/deploy-cloudflare-pages.yml` membangun Flutter Web, menjalankan analisis dan tes, lalu mengirim hasil `build/web` ke Cloudflare Pages. Workflow berjalan otomatis saat ada push ke branch `main`, atau bisa dijalankan dari tab **Actions** di GitHub.

1. Masukkan proyek ini ke repository GitHub dan push ke branch `main`.
2. Buat proyek Pages bernama `ruang-aman-perempuan-anak` dengan Wrangler (setelah login ke akun Cloudflare):

   ```shell
   npx wrangler login
   npx wrangler pages project create ruang-aman-perempuan-anak --production-branch main
   ```

3. Buat Cloudflare API Token dengan izin **Account → Cloudflare Pages → Edit** untuk akun yang benar.
4. Di repository GitHub, buka **Settings → Secrets and variables → Actions** dan tambahkan repository secrets:
   - `SIPELKA`: API token dari langkah sebelumnya.
   - `CLOUDFLARE_ACCOUNT_ID`: Account ID Cloudflare.
5. Push perubahan ke `main`, kemudian pantau hasilnya di tab **Actions**. Setelah berhasil, buka domain `*.pages.dev` yang ditampilkan di Cloudflare Pages.

Jangan masukkan token atau Account ID ke source code, dan jangan kirim API token melalui chat. Deploy dari branch selain `main` akan menjadi preview deployment.

## Cakupan aplikasi

- Beranda dengan informasi keselamatan.
- Formulir mewajibkan seluruh data pelapor dan korban (termasuk alamat kabupaten/kecamatan/desa atau kelurahan), serta berisi data pelaku, jenis kejadian, dan kronologi.
- Pengiriman pengaduan dilakukan melalui Cloudflare Pages Function dan Google Sheets API. Kredensial Google disimpan sebagai Cloudflare Pages secret dan tidak dikirim ke browser.
- Sebelum mengirim, pelapor harus menyatakan laporan aman dikirim dan memberi persetujuan eksplisit untuk menyimpan data di Google Sheet.

## Mengaktifkan penyimpanan Google Sheets

Endpoint gagal secara aman dan tidak menyimpan laporan sampai konfigurasi berikut selesai:

1. Di Google Cloud, aktifkan **Google Sheets API**, buat service account khusus, lalu buat key JSON. Jangan commit atau kirim key ini lewat chat.
2. Bagikan spreadsheet privat kepada email service account dengan izin **Editor**. Jangan ubah akses sheet menjadi publik.
3. Pada tab `Sheet1`, buat baris judul dengan urutan kolom berikut:

   `Waktu UTC`, `Nama pelapor`, `Hubungan pelapor-korban`, `Nomor kontak`, `Nama korban`, `Usia korban`, `Kabupaten`, `Kecamatan`, `Desa/kelurahan`, `Status nama pelaku`, `Nama pelaku`, `Usia pelaku`, `Alamat pelaku`, `Hubungan pelaku-korban`, `Jenis kejadian`, `Kronologi`, `Aman dihubungi`, `Persetujuan penyimpanan`.

4. Di pengaturan Cloudflare Pages proyek **ruang-aman-perempuan-anak**, tambahkan production environment variables:
   - `ALLOWED_ORIGIN`: `https://ruang-aman-perempuan-anak.pages.dev`
   - `GOOGLE_SHEETS_SPREADSHEET_ID`: ID dari URL spreadsheet.
   - `GOOGLE_SHEETS_TAB`: `Sheet1`
5. Tambahkan `GOOGLE_SERVICE_ACCOUNT_JSON` sebagai **secret** Pages menggunakan isi key JSON service account. Jangan letakkan key di source code, GitHub, atau variabel yang terekspos ke browser. Jika key pernah terekspos, cabut dan rotasi segera.
6. Setelah secret dan variabel aktif, lakukan deployment ulang. Uji hanya dengan data fiktif, lalu pastikan satu baris uji muncul dan akses spreadsheet hanya diberikan kepada petugas berwenang.
7. Tambahkan Cloudflare rate-limiting rule untuk `/api/complaints` (misalnya maksimal 5 permintaan per alamat IP dalam 10 menit) dan pantau penyalahgunaan sebelum membuka formulir kepada publik.

Sheet berisi data sensitif: batasi akses, tetapkan penanggung jawab serta kebijakan retensi/penghapusan, dan jangan gunakan data laporan sungguhan sebelum organisasi menyetujui kebijakan privasi, keamanan, dan alur respons. Persetujuan pada formulir menjelaskan pengiriman ke Google Sheet, tetapi tidak menggantikan persetujuan/kebijakan organisasi atau menjamin tindak lanjut dan bantuan darurat. Endpoint hanya menerima permintaan dari origin Pages yang dikonfigurasi dan memvalidasi data; pemeriksaan origin bukan bukti identitas pelapor. Jangan aktifkan penerimaan data nyata sebelum konfigurasi, rate limiting, dan proses penanganan laporan siap.
