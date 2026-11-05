import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const _plum = Color(0xFF713B62);
const _rose = Color(0xFFD96F91);
const _coral = Color(0xFFF08A72);
const _teal = Color(0xFF398D83);
const _ink = Color(0xFF312735);
const _mutedInk = Color(0xFF756A76);
const _canvas = Color(0xFFFFF8F5);

void main() {
  runApp(const SiperempuanAnakApp());
}

class SiperempuanAnakApp extends StatelessWidget {
  const SiperempuanAnakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ruang Aman',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _plum,
          primary: _plum,
          secondary: _rose,
          tertiary: _teal,
          surface: _canvas,
        ),
        scaffoldBackgroundColor: _canvas,
        appBarTheme: const AppBarTheme(
          backgroundColor: _canvas,
          foregroundColor: _ink,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: _ink,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: const BorderSide(color: Color(0xFFF0E5EA)),
          ),
          margin: EdgeInsets.zero,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFFFEFD),
          labelStyle: const TextStyle(
            color: _mutedInk,
            fontWeight: FontWeight.w600,
          ),
          hintStyle: const TextStyle(color: Color(0xFFAA9EA6)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFEBDDE4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFEBDDE4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: _rose, width: 1.8),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: _plum,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
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
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [_plum, _rose],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(17),
                    boxShadow: [
                      BoxShadow(
                        color: _plum.withValues(alpha: 0.18),
                        blurRadius: 16,
                        offset: const Offset(0, 7),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.favorite_rounded,
                      color: Colors.white, size: 23),
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
                            color: _plum)),
                    Text('Perempuan & Anak',
                        style: TextStyle(
                            fontSize: 17,
                            color: _ink,
                            fontWeight: FontWeight.w800)),
                  ],
                ),
                const Spacer(),
                Material(
                  color: const Color(0xFFEAF5F2),
                  borderRadius: BorderRadius.circular(15),
                  child: IconButton(
                    tooltip: 'Informasi keamanan',
                    onPressed: () => _showSafety(context),
                    icon: const Icon(Icons.shield_outlined, color: _teal),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(23, 24, 23, 25),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [_plum, Color(0xFF9D547D), _rose],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _HeroBadge(),
                        SizedBox(height: 18),
                        Text(
                          'Kamu tidak sendiri.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            height: 1.15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Kamu berhak merasa aman dan didengarkan. Cari bantuan sesuai kebutuhanmu.',
                          style: TextStyle(
                            color: Color(0xFFFFF1F6),
                            fontSize: 14,
                            height: 1.55,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: -26,
                    top: -34,
                    child: _HeroOrb(
                      size: 130,
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                  Positioned(
                    right: 45,
                    bottom: -64,
                    child: _HeroOrb(
                      size: 120,
                      color: const Color(0xFFFFD6B8).withValues(alpha: 0.14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 27),
            const Text(
              'Apa yang kamu butuhkan?',
              style: TextStyle(
                fontSize: 19,
                color: _ink,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 13),
            _ActionCard(
              icon: Icons.edit_note_rounded,
              iconColor: _plum,
              iconBackground: const Color(0xFFF7E9F1),
              title: 'Buat pengaduan',
              subtitle: 'Ceritakan kejadian dengan cara yang terasa aman.',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const ComplaintPage()),
              ),
            ),
            const SizedBox(height: 11),
            _ActionCard(
              icon: Icons.health_and_safety_outlined,
              iconColor: _teal,
              iconBackground: const Color(0xFFE8F4F1),
              title: 'Butuh bantuan segera?',
              subtitle:
                  'Jika dalam bahaya, cari tempat aman dan hubungi bantuan.',
              onTap: () => _showEmergency(context),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                color: Color(0xFFFFF0E7),
                borderRadius: BorderRadius.all(Radius.circular(23)),
                border: Border.fromBorderSide(
                  BorderSide(color: Color(0xFFF9E0D2)),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.spa_rounded, color: _coral, size: 21),
                      SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          'Langkah kecil, tetap kendalimu',
                          style: TextStyle(
                            fontSize: 16,
                            color: _ink,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _TipRow(
                    number: '1',
                    text: 'Gunakan perangkat yang aman dan tidak dipantau.',
                  ),
                  _TipRow(
                    number: '2',
                    text: 'Kamu boleh berhenti kapan saja saat mengisi cerita.',
                  ),
                  _TipRow(
                    number: '3',
                    text:
                        'Jangan sertakan detail yang membuatmu merasa tidak aman.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF5F2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline_rounded, color: _teal, size: 19),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Pengaduan tersimpan setelah layanan terhubung. Ini bukan layanan darurat dan tidak menjamin respons segera.',
                      style: TextStyle(
                        color: Color(0xFF426E69),
                        fontSize: 12,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
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
          'Aplikasi ini tidak menjamin kerahasiaan perangkat. Pengaduan yang berhasil dikirim '
          'akan disimpan di Google Sheet layanan.',
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

class _HeroBadge extends StatelessWidget {
  const _HeroBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.waving_hand_rounded, color: Color(0xFFFFDDA5), size: 17),
          SizedBox(width: 7),
          Text(
            'RUANG UNTUK BERCERITA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              letterSpacing: 1,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroOrb extends StatelessWidget {
  const _HeroOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(21),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21),
          border: Border.all(color: const Color(0xFFF0E5EA)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0C713B62),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(21),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: iconBackground,
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Icon(icon, color: iconColor, size: 27),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: _ink,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: _mutedInk,
                          height: 1.4,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward_rounded,
                    color: iconColor.withValues(alpha: 0.8), size: 20),
              ],
            ),
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
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [_coral, _rose]),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF655A62),
                  height: 1.4,
                  fontSize: 13,
                ),
              ),
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
  bool _isSubmitting = false;

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
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF7E9F1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.edit_note_rounded, color: _plum),
            ),
            const SizedBox(width: 11),
            const Text('Buat pengaduan'),
          ],
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4E8),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFFF6E0C8)),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline_rounded, color: _coral),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Saat dikirim, data akan diteruskan melalui internet dan disimpan '
                        'di Google Sheet layanan untuk ditinjau petugas berwenang. '
                        'Kirim hanya jika perangkat aman dan kamu menyetujui penyimpanan ini.',
                        style: TextStyle(
                          color: Color(0xFF755746),
                          height: 1.45,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 23),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF9EAF1), Color(0xFFF1EBF7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFF0DCE7)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.edit_note_rounded, color: _plum, size: 26),
                    SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'FORMULIR PENGADUAN',
                            style: TextStyle(
                              color: _plum,
                              fontSize: 10,
                              letterSpacing: 1.1,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Isi bagian yang tersedia sesuai kenyamananmu.',
                            style: TextStyle(
                              color: _ink,
                              fontSize: 13,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _sectionTitle('Data pelapor'),
              const SizedBox(height: 10),
              TextFormField(
                controller: _reporterNameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nama pelapor (wajib)',
                  hintText: 'Nama yang dapat digunakan admin untuk menyapa',
                ),
                validator: _requiredValidator('Masukkan nama pelapor.'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _reporterRelationship,
                decoration: const InputDecoration(
                  labelText: 'Hubungan dengan korban (wajib)',
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
                  labelText: 'Nomor kontak pelapor (wajib)',
                  hintText: 'Contoh: 08xxxxxxxxxx',
                  helperText: 'Gunakan nomor yang aman untuk dihubungi.',
                ),
                validator: (value) {
                  final digits =
                      (value ?? '').replaceAll(RegExp(r'[^0-9]'), '');
                  if (digits.isEmpty) {
                    return 'Masukkan nomor kontak pelapor.';
                  }
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
                  labelText: 'Nama korban (wajib)',
                ),
                validator: _requiredValidator('Masukkan nama korban.'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _victimAgeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Usia korban (wajib)',
                  hintText: 'Perkiraan usia dalam tahun',
                ),
                validator: _requiredAgeValidator,
              ),
              const SizedBox(height: 12),
              const Text(
                'Alamat korban (wajib)',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _victimDistrictController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Kabupaten (wajib)',
                  helperText:
                      'Isi lokasi secara umum jika aman untuk dibagikan.',
                ),
                validator: _requiredValidator('Masukkan kabupaten korban.'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _victimSubdistrictController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Kecamatan (wajib)',
                ),
                validator: _requiredValidator('Masukkan kecamatan korban.'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _victimVillageController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Desa/kelurahan (wajib)',
                ),
                validator:
                    _requiredValidator('Masukkan desa/kelurahan korban.'),
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
                tileColor: const Color(0xFFF8EEF3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
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
                tileColor: const Color(0xFFEAF5F2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                value: _privacyConsent,
                onChanged: (value) =>
                    setState(() => _privacyConsent = value ?? false),
                title: const Text(
                  'Saya setuju data pengaduan ini, termasuk data pribadi dan kronologi, '
                  'dikirim dan disimpan di Google Sheet milik layanan agar dapat ditinjau '
                  'petugas berwenang.',
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
                onPressed: _isSubmitting ? null : _submit,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_isSubmitting ? 'Mengirim...' : 'Kirim pengaduan'),
                    const SizedBox(width: 9),
                    if (_isSubmitting)
                      const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    else
                      const Icon(Icons.send_rounded, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    if (!_safeToContact || !_privacyConsent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Mohon lengkapi persetujuan yang diperlukan.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final response = await http
          .post(
            Uri.base.resolve('/api/complaints'),
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode({
              'reporterName': _reporterNameController.text.trim(),
              'reporterRelationship': _reporterRelationship,
              'reporterPhone': _reporterPhoneController.text.trim(),
              'victimName': _victimNameController.text.trim(),
              'victimAge': int.tryParse(_victimAgeController.text.trim()),
              'victimDistrict': _victimDistrictController.text.trim(),
              'victimSubdistrict': _victimSubdistrictController.text.trim(),
              'victimVillage': _victimVillageController.text.trim(),
              'perpetratorNameStatus': _perpetratorNameStatus,
              'perpetratorName': _perpetratorNameController.text.trim(),
              'perpetratorAge':
                  int.tryParse(_perpetratorAgeController.text.trim()),
              'perpetratorAddress': _perpetratorAddressController.text.trim(),
              'perpetratorRelationship': _perpetratorRelationship,
              'incidentType': _incidentType,
              'story': _storyController.text.trim(),
              'safeToContact': _safeToContact,
              'privacyConsent': _privacyConsent,
            }),
          )
          .timeout(const Duration(seconds: 25));
      final responseBody = jsonDecode(response.body);
      if (response.statusCode != 201 ||
          responseBody is! Map<String, dynamic> ||
          responseBody['saved'] != true) {
        final message =
            responseBody is Map<String, dynamic> ? responseBody['error'] : null;
        throw _SubmissionException(
          message is String
              ? message
              : 'Pengaduan belum tersimpan. Silakan coba lagi nanti.',
        );
      }

      if (!mounted) return;
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => ConfirmationPage(incidentType: _incidentType!),
        ),
      );
    } on _SubmissionException catch (error) {
      _showSubmissionError(error.message);
    } on http.ClientException {
      _showSubmissionError(
        'Status pengiriman belum dapat dipastikan. Jika masalah berlanjut, '
        'hubungi petugas layanan sebelum mengirim ulang.',
      );
    } on TimeoutException {
      _showSubmissionError(
        'Status pengiriman belum dapat dipastikan. Karena layanan terlalu lama '
        'merespons, hubungi petugas sebelum mengirim ulang.',
      );
    } on FormatException {
      _showSubmissionError(
        'Respons layanan tidak valid. Pengaduan belum dapat dipastikan tersimpan.',
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showSubmissionError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
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

  String? _requiredAgeValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Masukkan usia korban.';
    }
    return _ageValidator(value);
  }

  Widget _sectionTitle(String title) {
    final (icon, accent, tint) = switch (title) {
      'Data pelapor' => (
          Icons.person_rounded,
          _plum,
          const Color(0xFFF7EAF2),
        ),
      'Data korban' => (
          Icons.favorite_rounded,
          _rose,
          const Color(0xFFFFEEF1),
        ),
      'Data pelaku' => (
          Icons.shield_outlined,
          _teal,
          const Color(0xFFEAF5F2),
        ),
      'Informasi kejadian' => (
          Icons.event_note_rounded,
          _coral,
          const Color(0xFFFFF1E8),
        ),
      _ => (
          Icons.auto_stories_rounded,
          _plum,
          const Color(0xFFF2EDF7),
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.78),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, color: accent, size: 20),
          ),
          const SizedBox(width: 11),
          Text(
            title,
            style: const TextStyle(
              color: _ink,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          Icon(Icons.circle, size: 7, color: accent.withValues(alpha: 0.65)),
          const SizedBox(width: 5),
          Icon(Icons.circle, size: 7, color: accent.withValues(alpha: 0.38)),
          const SizedBox(width: 5),
          Icon(Icons.circle, size: 7, color: accent.withValues(alpha: 0.2)),
        ],
      ),
    );
  }
}

class _SubmissionException implements Exception {
  const _SubmissionException(this.message);

  final String message;
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
                'Pengaduan sudah tersimpan di Google Sheet layanan untuk ditinjau petugas '
                'berwenang. Penyimpanan ini belum menjamin tindak lanjut atau respons darurat.',
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
                        'Data pribadi tidak ditampilkan kembali di halaman ini.',
                      ),
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
