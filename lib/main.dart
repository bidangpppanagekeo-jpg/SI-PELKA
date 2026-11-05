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
                MaterialPageRoute<void>(builder: (_) => const ComplaintPage()),
              ),
            ),
            const SizedBox(height: 11),
            _ActionCard(
              icon: Icons.health_and_safety_outlined,
              title: 'Butuh bantuan segera?',
              subtitle:
                  'Jika dalam bahaya, cari tempat aman dan hubungi bantuan.',
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
              'MVP demo: formulir belum terhubung ke admin dinas. Jangan masukkan data pribadi nyata.',
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
              const Icon(Icons.chevron_right_rounded, color: Color(0xFF8C7A87)),
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
                  style:
                      const TextStyle(color: Color(0xFF514950), height: 1.4)),
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
  final _reporterNameController = TextEditingController();
  final _reporterPhoneController = TextEditingController();
  final _victimNameController = TextEditingController();
  final _victimAgeController = TextEditingController();
  final _victimDistrictController = TextEditingController();
  final _victimSubdistrictController = TextEditingController();
  final _victimVillageController = TextEditingController();
  final _perpetratorNameController = TextEditingController();
  final _perpetratorAgeController = TextEditingController();
  final _perpetratorAddressController = TextEditingController();
  final _storyController = TextEditingController();
  String _perpetratorNameStatus = 'Diketahui';
  String? _perpetratorRelationship;
  String? _incidentType;
  String? _reporterRelationship;
  bool _safeToContact = false;
  bool _privacyConsent = false;

  @override
  void dispose() {
    _reporterNameController.dispose();
    _reporterPhoneController.dispose();
    _victimNameController.dispose();
    _victimAgeController.dispose();
    _victimDistrictController.dispose();
    _victimSubdistrictController.dispose();
    _victimVillageController.dispose();
    _perpetratorNameController.dispose();
    _perpetratorAgeController.dispose();
    _perpetratorAddressController.dispose();
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
                        'Formulir ini belum terhubung ke admin dinas. Data yang diisi hanya '
                        'berada sementara di layar ini, tidak dikirim atau disimpan. '
                        'Jangan gunakan data pribadi nyata sampai layanan resmi tersedia.',
                        style: TextStyle(height: 1.45, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 23),
              _sectionTitle('Data pelapor'),
              const SizedBox(height: 10),
              TextFormField(
                controller: _reporterNameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nama pelapor',
                  hintText: 'Nama yang dapat digunakan admin untuk menyapa',
                ),
                validator: _requiredValidator('Masukkan nama pelapor.'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _reporterRelationship,
                decoration: const InputDecoration(
                  labelText: 'Hubungan dengan korban',
                  hintText: 'Pilih hubungan',
                ),
                items: const [
                  DropdownMenuItem(value: 'Korban', child: Text('Saya korban')),
                  DropdownMenuItem(value: 'Keluarga', child: Text('Keluarga')),
                  DropdownMenuItem(value: 'Saksi', child: Text('Saksi')),
                  DropdownMenuItem(
                      value: 'Pendamping', child: Text('Pendamping')),
                  DropdownMenuItem(value: 'Lainnya', child: Text('Lainnya')),
                ],
                onChanged: (value) =>
                    setState(() => _reporterRelationship = value),
                validator: (value) =>
                    value == null ? 'Pilih hubungan dengan korban.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _reporterPhoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor kontak pelapor',
                  hintText: 'Contoh: 08xxxxxxxxxx',
                  helperText: 'Gunakan nomor yang aman untuk dihubungi.',
                ),
                validator: (value) {
                  final digits =
                      (value ?? '').replaceAll(RegExp(r'[^0-9]'), '');
                  if (digits.length < 9 || digits.length > 15) {
                    return 'Masukkan nomor kontak yang valid.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              _sectionTitle('Data korban'),
              const SizedBox(height: 10),
              TextFormField(
                controller: _victimNameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nama korban (opsional)',
                  helperText:
                      'Kosongkan jika belum aman atau belum mengetahui nama.',
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _victimAgeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Usia korban (opsional)',
                  hintText: 'Perkiraan usia dalam tahun',
                ),
                validator: _ageValidator,
              ),
              const SizedBox(height: 12),
              const Text(
                'Alamat korban (opsional)',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _victimDistrictController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Kabupaten',
                  helperText:
                      'Isi lokasi secara umum jika aman untuk dibagikan.',
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _victimSubdistrictController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Kecamatan',
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _victimVillageController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Desa/kelurahan',
                ),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Data pelaku'),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                key: const ValueKey('perpetrator-name-status'),
                initialValue: _perpetratorNameStatus,
                decoration: const InputDecoration(
                  labelText: 'Status nama pelaku',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Diketahui',
                    child: Text('Diketahui'),
                  ),
                  DropdownMenuItem(
                    value: 'Tidak diketahui',
                    child: Text('Tidak diketahui'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _perpetratorNameStatus = value;
                      if (value == 'Tidak diketahui') {
                        _perpetratorNameController.clear();
                      }
                    });
                  }
                },
              ),
              if (_perpetratorNameStatus == 'Diketahui') ...[
                const SizedBox(height: 12),
                TextFormField(
                  controller: _perpetratorNameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Nama pelaku (opsional)',
                  ),
                ),
              ],
              const SizedBox(height: 12),
              TextFormField(
                controller: _perpetratorAgeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Usia pelaku (opsional)',
                  hintText: 'Perkiraan usia dalam tahun',
                ),
                validator: _ageValidator,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _perpetratorAddressController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Alamat pelaku (opsional)',
                  helperText:
                      'Isi hanya jika diketahui dan aman untuk dibagikan.',
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _perpetratorRelationship,
                decoration: const InputDecoration(
                  labelText: 'Hubungan pelaku dengan korban (opsional)',
                  hintText: 'Pilih hubungan jika diketahui',
                ),
                items: const [
                  DropdownMenuItem(value: 'Keluarga', child: Text('Keluarga')),
                  DropdownMenuItem(value: 'Pasangan', child: Text('Pasangan')),
                  DropdownMenuItem(value: 'Teman', child: Text('Teman')),
                  DropdownMenuItem(value: 'Tetangga', child: Text('Tetangga')),
                  DropdownMenuItem(
                    value: 'Rekan kerja',
                    child: Text('Rekan kerja'),
                  ),
                  DropdownMenuItem(
                    value: 'Orang tidak dikenal',
                    child: Text('Orang tidak dikenal'),
                  ),
                  DropdownMenuItem(value: 'Lainnya', child: Text('Lainnya')),
                ],
                onChanged: (value) =>
                    setState(() => _perpetratorRelationship = value),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Informasi kejadian'),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                initialValue: _incidentType,
                decoration: const InputDecoration(
                  labelText: 'Jenis kejadian',
                  hintText: 'Pilih yang sesuai',
                ),
                items: const [
                  DropdownMenuItem(
                      value: 'Fisik', child: Text('Kekerasan fisik')),
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
              const SizedBox(height: 24),
              _sectionTitle('Kronologi kejadian'),
              const SizedBox(height: 10),
              const Text('Ceritakan seperlunya saja',
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
              const SizedBox(height: 12),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                value: _safeToContact,
                onChanged: (value) =>
                    setState(() => _safeToContact = value ?? false),
                title: const Text(
                  'Aman untuk dihubungi melalui nomor tersebut.',
                  style: TextStyle(fontSize: 13, height: 1.35),
                ),
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                value: _privacyConsent,
                onChanged: (value) =>
                    setState(() => _privacyConsent = value ?? false),
                title: const Text(
                  'Saya memahami data kontak digunakan untuk konfirmasi oleh admin dinas '
                  'setelah layanan resmi tersedia. Saat ini formulir hanya demo dan tidak '
                  'mengirim data.',
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
                child: const Text('Lihat ringkasan demo'),
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
    if (!_safeToContact || !_privacyConsent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Mohon lengkapi persetujuan yang diperlukan.')),
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

  String? Function(String?) _requiredValidator(String message) {
    return (value) => value == null || value.trim().isEmpty ? message : null;
  }

  String? _ageValidator(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;
    final age = int.tryParse(text);
    if (age == null || age < 0 || age > 120) {
      return 'Masukkan usia antara 0 sampai 120 tahun.';
    }
    return null;
  }

  Widget _sectionTitle(String title) {
    return Text(title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700));
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
                'Ini hanya ringkasan demo di perangkatmu, bukan pengaduan resmi. '
                'Admin dinas belum menerima laporan dan tidak dapat menghubungi melalui formulir ini.',
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
                      const Text(
                          'Data kontak tidak disimpan atau ditampilkan kembali.'),
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
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
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
