import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siperempuan_anak/main.dart';

void main() {
  testWidgets('beranda membuka formulir pengaduan', (tester) async {
    await tester.pumpWidget(const SiperempuanAnakApp());

    expect(find.text('Kamu tidak sendiri.'), findsOneWidget);
    await tester.tap(find.text('Buat pengaduan'));
    await tester.pumpAndSettle();

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

    expect(find.text('Data pelapor'), findsOneWidget);
    expect(find.text('Nama pelapor'), findsOneWidget);
    expect(find.text('Hubungan dengan korban'), findsOneWidget);
    expect(find.text('Nomor kontak pelapor'), findsOneWidget);
    expect(find.text('Data korban'), findsOneWidget);
    expect(find.text('Nama korban (opsional)'), findsOneWidget);
    await expectVisible(find.text('Alamat korban (opsional)'));
    await expectVisible(find.text('Kabupaten'));
    await expectVisible(find.text('Kecamatan'));
    await expectVisible(find.text('Desa/kelurahan'));
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
    await expectVisible(find.text('Lihat ringkasan demo'));
  });
}
