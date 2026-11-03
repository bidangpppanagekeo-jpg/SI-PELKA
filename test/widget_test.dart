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
    expect(find.text('Informasi kejadian'), findsOneWidget);
    await tester.ensureVisible(find.text('Ceritakan seperlunya'));
    await tester.pumpAndSettle();
    expect(find.text('Ceritakan seperlunya'), findsOneWidget);
    await tester.ensureVisible(find.text('Lihat ringkasan demo'));
    await tester.pumpAndSettle();
    expect(find.text('Aman untuk dihubungi melalui nomor tersebut.'),
        findsOneWidget);
    expect(find.text('Lihat ringkasan demo'), findsOneWidget);
  });
}
