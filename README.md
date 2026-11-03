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
   - `CLOUDFLARE_API_TOKEN`: API token dari langkah sebelumnya.
   - `CLOUDFLARE_ACCOUNT_ID`: Account ID Cloudflare.
5. Push perubahan ke `main`, kemudian pantau hasilnya di tab **Actions**. Setelah berhasil, buka domain `*.pages.dev` yang ditampilkan di Cloudflare Pages.

Jangan masukkan token atau Account ID ke source code, dan jangan kirim API token melalui chat. Deploy dari branch selain `main` akan menjadi preview deployment.

## Cakupan demo

- Beranda dengan informasi keselamatan.
- Formulir pengaduan anonim dengan kategori kejadian dan cerita singkat.
- Konfirmasi bahwa laporan tidak diteruskan ke petugas.
- Data formulir hanya berada di memori selama alur berlangsung; aplikasi ini tidak mengirim atau menyimpan laporan.

**Jangan gunakan demo ini untuk pengaduan nyata.** Belum ada backend, pemantauan petugas, enkripsi penyimpanan, atau mekanisme penanganan darurat. Sebelum digunakan sungguhan, integrasikan dengan layanan resmi yang berwenang dan lakukan peninjauan keamanan, privasi, aksesibilitas, serta keselamatan pengguna.
