# Ruang Aman — Perempuan & Anak

Aplikasi Flutter berbahasa Indonesia untuk informasi dan alur pengaduan perempuan dan anak.

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
- Penanggung jawab data: Bidang PPPA, Dinas PMDP3A Kabupaten Nagekeo. Kebijakan instansi menetapkan masa simpan paling lama 3 bulan; petugas pengelola harus menghapus data sesuai masa retensi.
- Cakupan yang disetujui saat ini adalah uji coba terbatas untuk petugas, bukan penerimaan laporan publik.

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
6. Deploy dalam keadaan intake tertutup. Tanpa production variable `COMPLAINT_INTAKE_ENABLED=true`, endpoint menolak penyimpanan dengan HTTP 503. Jangan mengaktifkannya dulu.
7. Lindungi hostname produksi `ruang-aman-perempuan-anak.pages.dev` dengan Cloudflare Access dan kebijakan allowlist akun kerja petugas. Kebijakan Pages bawaan dapat hanya melindungi preview; pastikan hostname produksi juga dilindungi. Uji dari browser tanpa login bahwa aplikasi tidak dapat diakses. Pemeriksaan `Origin` di Function bukan autentikasi.
8. Setelah Access pada hostname produksi terverifikasi, set `COMPLAINT_INTAKE_ENABLED` ke `true`. Uji dengan akun petugas dan data fiktif saja, pastikan satu baris masuk, lalu hapus baris uji tanpa mengubah header. Pastikan akses spreadsheet hanya diberikan kepada petugas berwenang.
9. Tetapkan SOP respons dan jadwal penghapusan. Retensi 3 bulan belum diotomatisasi oleh aplikasi; petugas pengelola harus memastikan baris dihapus sesuai kebijakan, termasuk dari salinan/backup yang berlaku. Terapkan rate limiting sebelum membuka intake publik.

Sheet berisi data sangat sensitif: tetap batasi akses, tinjau akses petugas berkala, dan jangan gunakan data laporan sungguhan selama uji coba. Persetujuan pada formulir tidak menggantikan persetujuan/kebijakan organisasi, tidak menjamin tindak lanjut, dan bukan bantuan darurat. Jangan membuka intake publik sebelum organisasi menyetujui kebijakan privasi, retensi/penghapusan, kontrol akses, rate limiting, dan proses penanganan laporan.
