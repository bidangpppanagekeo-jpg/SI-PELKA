import 'package:flutter_test/flutter_test.dart';
import 'package:siperempuan_anak/main.dart';

void main() {
  testWidgets('beranda membuka formulir pengaduan', (tester) async {
    await tester.pumpWidget(const SiperempuanAnakApp());

    expect(find.text('Kamu tidak sendiri.'), findsOneWidget);
    await tester.tap(find.text('Buat pengaduan'));
    await tester.pumpAndSettle();

    expect(find.text('Jenis kejadian'), findsOneWidget);
    expect(find.text('Ceritakan seperlunya'), findsOneWidget);
    expect(find.text('Lanjutkan'), findsOneWidget);
  });
}
