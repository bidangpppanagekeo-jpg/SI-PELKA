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
    await tester.dragUntilVisible(
      find.text('Ceritakan seperlunya'),
      find.byType(ListView).last,
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();
    expect(find.text('Ceritakan seperlunya'), findsOneWidget);
    await tester.dragUntilVisible(
      find.text('Lihat ringkasan demo'),
      find.byType(ListView).last,
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();
    expect(find.text('Aman untuk dihubungi melalui nomor tersebut.'),
        findsOneWidget);
    expect(find.text('Lihat ringkasan demo'), findsOneWidget);
  });
}
