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

## Cakupan demo

- Beranda dengan informasi keselamatan.
- Formulir demo berisi data pelapor, korban (termasuk alamat kabupaten/kecamatan/desa atau kelurahan), pelaku, jenis kejadian, dan kronologi.
- Persetujuan kontak balik dan keterangan bahwa data tidak terkirim.
- Data formulir hanya berada sementara di memori selama alur berlangsung; aplikasi ini tidak mengirim atau menyimpan laporan.

**Jangan gunakan formulir demo ini dengan data pribadi nyata atau untuk pengaduan sungguhan.** Belum ada backend, petugas yang menerima laporan, kebijakan retensi, enkripsi penyimpanan, atau mekanisme penanganan darurat. Sebelum penggunaan resmi, dinas perlu menyiapkan backend terlindungi, akses petugas berbasis peran, audit akses, kebijakan privasi dan retensi, serta prosedur respons dan keselamatan; lakukan peninjauan keamanan dan privasi terlebih dahulu.
