import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siperempuan_anak/main.dart';

void main() {
  testWidgets('beranda membuka formulir pengaduan', (tester) async {
    await tester.pumpWidget(const SiperempuanAnakApp());

    expect(find.text('Kamu tidak sendiri.'), findsOneWidget);
    expect(find.text('RUANG UNTUK BERCERITA'), findsOneWidget);
    await tester.tap(find.text('Buat pengaduan'));
    await tester.pumpAndSettle();

    expect(
      find.textContaining(
          'Aplikasi ini saat ini hanya untuk uji coba terbatas'),
      findsOneWidget,
    );
    expect(find.text('Panduan mengisi formulir'), findsOneWidget);
    expect(find.text('Informasi kejadian'), findsOneWidget);
    expect(
      find.textContaining('tidak perlu menebak atau menulis detail'),
      findsOneWidget,
    );
    final list = find.byType(ListView).last;
    Future<void> expectVisible(Finder target) async {
      var attempts = 0;
      while (target.evaluate().isEmpty && attempts < 20) {
        await tester.drag(list, const Offset(0, -400));
        await tester.pumpAndSettle();
        attempts++;
      }
      expect(target, findsOneWidget);
      await tester.ensureVisible(target);
      await tester.pumpAndSettle();
    }

    await expectVisible(find.text('Data pelapor'));
    await expectVisible(find.text('FORMULIR PENGADUAN'));
    expect(find.text('Nama pelapor (wajib)'), findsOneWidget);
    expect(find.text('Hubungan dengan korban (wajib)'), findsOneWidget);
    expect(find.text('Nomor kontak pelapor (wajib)'), findsOneWidget);
    await expectVisible(find.text('Data korban'));
    await expectVisible(find.text('Nama korban (wajib)'));
    await expectVisible(find.text('Alamat korban (wajib)'));
    await expectVisible(find.text('Kabupaten (wajib)'));
    await expectVisible(find.text('Kecamatan (wajib)'));
    await expectVisible(find.text('Desa/kelurahan (wajib)'));
    await expectVisible(find.text('Data pelaku'));
    await expectVisible(find.text('Status nama pelaku'));
    final nameStatus = find.byKey(const ValueKey('perpetrator-name-status'));
    expect(nameStatus, findsOneWidget);
    await tester.tap(nameStatus);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tidak diketahui'));
    await tester.pumpAndSettle();
    expect(find.text('Nama pelaku (opsional)'), findsNothing);
    await tester.tap(nameStatus);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Diketahui'));
    await tester.pumpAndSettle();
    await expectVisible(find.text('Nama pelaku (opsional)'));
    await expectVisible(find.text('Usia pelaku (opsional)'));
    await expectVisible(find.text('Alamat pelaku (opsional)'));
    await expectVisible(
      find.text('Hubungan pelaku dengan korban (opsional)'),
    );
    await expectVisible(find.text('Informasi kejadian'));
    await expectVisible(find.text('Kronologi kejadian'));
    await expectVisible(find.text('Ceritakan seperlunya saja'));
    await expectVisible(
      find.text('Aman untuk dihubungi melalui nomor tersebut.'),
    );
    expect(find.text('Aman untuk dihubungi melalui nomor tersebut.'),
        findsOneWidget);
    await expectVisible(
      find.textContaining(
          'dikirim dan disimpan di Google Sheet yang dikelola Bidang PPPA'),
    );
    await expectVisible(
      find.textContaining('Data disimpan paling lama 3 bulan'),
    );
    await expectVisible(find.text('Kirim pengaduan'));
  });
}
