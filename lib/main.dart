import 'package:flutter/material.dart';

void main() {
  runApp(const SiperempuanAnakApp());
}

class SiperempuanAnakApp extends StatelessWidget {
  const SiperempuanAnakApp({super.key});

  @override
  Widget build(BuildContext context) {
    const plum = Color(0xFF713B62);
    return MaterialApp(
      title: 'Ruang Aman',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: plum,
          primary: plum,
          surface: const Color(0xFFFFFBF8),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFBF8),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE7DDE4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE7DDE4)),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2E5EF),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.favorite_rounded,
                      color: Color(0xFF713B62)),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('RUANG AMAN',
                        style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF713B62))),
                    Text('Perempuan & Anak',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700)),
                  ],
                ),
                const Spacer(),
                IconButton(
                  tooltip: 'Informasi keamanan',
                  onPressed: () => _showSafety(context),
                  icon: const Icon(Icons.shield_outlined),
                ),
              ],
            ),
            const SizedBox(height: 27),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF713B62), Color(0xFF985F83)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(26),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.waving_hand_rounded,
                      color: Color(0xFFFFDF9E), size: 28),
                  SizedBox(height: 16),
                  Text('Kamu tidak sendiri.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          height: 1.2,
                          fontWeight: FontWeight.w800)),
                  SizedBox(height: 9),
                  Text(
                    'Kamu berhak merasa aman dan didengarkan. Cari bantuan sesuai kebutuhanmu.',
                    style: TextStyle(
                        color: Color(0xFFF8EAF3), fontSize: 14, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text('Apa yang kamu butuhkan?',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700)),
            const SizedBox(height: 13),
            _ActionCard(
              icon: Icons.edit_note_rounded,
              title: 'Buat pengaduan',
              subtitle: 'Ceritakan kejadian dengan cara yang terasa aman.',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (_) => const ComplaintPage()),
              ),
            ),
            const SizedBox(height: 11),
            _ActionCard(
              icon: Icons.health_and_safety_outlined,
              title: 'Butuh bantuan segera?',
              subtitle: 'Jika dalam bahaya, cari tempat aman dan hubungi bantuan.',
              onTap: () => _showEmergency(context),
            ),
            const SizedBox(height: 25),
            const Text('Langkah kecil, tetap kendalimu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 13),
            const _TipRow(
              number: '1',
              text: 'Gunakan perangkat yang aman dan tidak dipantau.',
            ),
            const _TipRow(
              number: '2',
              text: 'Kamu boleh berhenti kapan saja saat mengisi cerita.',
            ),
            const _TipRow(
              number: '3',
              text: 'Jangan sertakan detail yang membuatmu merasa tidak aman.',
            ),
            const SizedBox(height: 18),
            const Text(
              'MVP demo: pengaduan belum dikirim atau disimpan ke layanan pendamping.',
              style: TextStyle(
                  color: Color(0xFF746A72), fontSize: 12, height: 1.45),
            ),
          ],
        ),
      ),
    );
  }

  void _showSafety(BuildContext context) {
    _showInfo(
      context,
      'Utamakan keselamatan',
      'Jika perangkat ini mungkin dipantau, pertimbangkan memakai perangkat orang tepercaya. '
          'Jangan gunakan aplikasi ini bila hal itu dapat meningkatkan risiko. '
          'MVP ini tidak mengirim laporan dan tidak menjamin kerahasiaan perangkat.',
    );
  }

  void _showEmergency(BuildContext context) {
    _showInfo(
      context,
      'Jika ada bahaya langsung',
      'Pindah ke tempat yang lebih aman bila memungkinkan dan hubungi orang tepercaya '
          'atau layanan darurat setempat. Untuk pendampingan, kamu juga dapat mencari '
          'layanan resmi perlindungan perempuan dan anak di daerahmu. Jangan menunggu '
          'mengisi formulir ini jika keselamatanmu terancam.',
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5EAF2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: const Color(0xFF713B62)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: const TextStyle(
                            color: Color(0xFF716770),
                            height: 1.35,
                            fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  color: Color(0xFF8C7A87)),
            ],
          ),
        ),
      ),
    );
  }
}

class _TipRow extends StatelessWidget {
  const _TipRow({required this.number, required this.text});

  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 25,
            height: 25,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Color(0xFFF2E5EF), shape: BoxShape.circle),
            child: Text(number,
                style: const TextStyle(
                    color: Color(0xFF713B62), fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(text,
                  style: const TextStyle(
                      color: Color(0xFF514950), height: 1.4)),
            ),
          ),
        ],
      ),
    );
  }
}

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final _formKey = GlobalKey<FormState>();
  final _storyController = TextEditingController();
  String? _incidentType;
  bool _confirmed = false;

  @override
  void dispose() {
    _storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buat pengaduan')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3DF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: Color(0xFF865C1C)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Jangan isi nama lengkap, alamat, atau informasi sensitif lainnya. '
                        'Data hanya berada di layar ini dan tidak dikirim ke mana pun.',
                        style: TextStyle(height: 1.45, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 23),
              const Text('Jenis kejadian',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 9),
              DropdownButtonFormField<String>(
                initialValue: _incidentType,
                decoration: const InputDecoration(hintText: 'Pilih yang sesuai'),
                items: const [
                  DropdownMenuItem(value: 'Fisik', child: Text('Kekerasan fisik')),
                  DropdownMenuItem(
                      value: 'Psikologis', child: Text('Kekerasan psikologis')),
                  DropdownMenuItem(
                      value: 'Seksual', child: Text('Kekerasan seksual')),
                  DropdownMenuItem(
                      value: 'Penelantaran', child: Text('Penelantaran')),
                  DropdownMenuItem(value: 'Lainnya', child: Text('Lainnya')),
                ],
                onChanged: (value) => setState(() => _incidentType = value),
                validator: (value) =>
                    value == null ? 'Pilih jenis kejadian.' : null,
              ),
              const SizedBox(height: 20),
              const Text('Ceritakan seperlunya',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 9),
              TextFormField(
                controller: _storyController,
                minLines: 5,
                maxLines: 8,
                maxLength: 1500,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText:
                      'Apa yang terjadi? Kamu tidak perlu menceritakan detail yang belum siap dibagikan.',
                  alignLabelWithHint: true,
                ),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Ceritakan singkat atau tulis “belum siap”.'
                    : null,
              ),
              const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.visibility_off_outlined),
                title: Text('Pengaduan tanpa identitas',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('Nama dan nomor kontak tidak diminta.'),
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                value: _confirmed,
                onChanged: (value) =>
                    setState(() => _confirmed = value ?? false),
                title: const Text(
                  'Saya memahami ini hanya demo dan laporan tidak diteruskan ke petugas.',
                  style: TextStyle(fontSize: 13, height: 1.35),
                ),
              ),
              const SizedBox(height: 10),
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: _submit,
                child: const Text('Lanjutkan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    if (!_confirmed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Mohon konfirmasi pemahaman sebelum melanjutkan.')),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ConfirmationPage(
          incidentType: _incidentType!,
        ),
      ),
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({
    required this.incidentType,
    super.key,
  });

  final String incidentType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ringkasan')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              const Icon(Icons.check_circle_outline_rounded,
                  size: 64, color: Color(0xFF713B62)),
              const SizedBox(height: 18),
              const Text('Terima kasih sudah bercerita',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              const Text(
                'Ini baru ringkasan di perangkatmu, bukan pengaduan resmi. '
                'Tidak ada data yang disimpan atau dikirim.',
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.5, color: Color(0xFF655A62)),
              ),
              const SizedBox(height: 24),
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jenis: $incidentType'),
                      const SizedBox(height: 8),
                      const Text('Identitas: tidak diminta'),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () => Navigator.of(context)
                    .popUntil((route) => route.isFirst),
                child: const Text('Kembali ke beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showInfo(BuildContext context, String title, String message) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message, style: const TextStyle(height: 1.45)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Mengerti'),
        ),
      ],
    ),
  );
}
