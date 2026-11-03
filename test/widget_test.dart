import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siperempuan_anak/main.dart';

void main() {
  testWidgets('beranda membuka formulir pengaduan', (tester) async {
    await tester.pumpWidget(const SiperempuanAnakApp());

    expect(find.text('Kamu tidak sendiri.'), findsOneWidget);
    await tester.tap(find.text('Buat pengaduan'));
    await tester.pumpAndSettle();

    expect(find.text('Data pelapor'), findsOneWidget);
    expect(find.text('Nama pelapor'), findsOneWidget);
    expect(find.text('Hubungan dengan korban'), findsOneWidget);
    expect(find.text('Nomor kontak pelapor'), findsOneWidget);
    expect(find.text('Data korban'), findsOneWidget);
    expect(find.text('Nama korban (opsional)'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Ceritakan seperlunya'),
      500,
      scrollable: find.descendant(
        of: find.byType(ComplaintPage),
        matching: find.byType(Scrollable),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Ceritakan seperlunya'), findsOneWidget);
    await tester.ensureVisible(find.text('Lihat ringkasan demo'));
    await tester.pumpAndSettle();
    expect(find.text('Aman untuk dihubungi melalui nomor tersebut.'),
        findsOneWidget);
    expect(find.text('Lihat ringkasan demo'), findsOneWidget);
  });
}
