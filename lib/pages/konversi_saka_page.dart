import 'package:flutter/material.dart';

class KonversiSakaPage extends StatefulWidget {
  const KonversiSakaPage({super.key});

  @override
  State<KonversiSakaPage> createState() => _KonversiSakaPageState();
}

class _KonversiSakaPageState extends State<KonversiSakaPage> {
  static final DateTime _minDate = DateTime(1937, 1, 1);
  static final DateTime _maxDate = DateTime(2076, 12, 31);

  DateTime? _tanggalMasehi;
  String _pesanError = '';
  bool _sudahDikonversi = false;

  int _sakaHari = 0;
  int _sakaBulan = 0;
  int _sakaTahun = 0;
  String _namaBulanSaka = '';
  String _namaHariSaka = '';
  String _hasilLengkapSaka = '';

  Future<void> _pickTanggalMasehi() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggalMasehi ?? DateTime.now(),
      firstDate: _minDate,
      lastDate: _maxDate,
    );

    if (picked != null) {
      setState(() {
        _tanggalMasehi = picked;
        _pesanError = '';
        _sudahDikonversi = false;
      });
    }
  }

  String _formatTanggal(DateTime date) {
    const namaBulan = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${date.day} ${namaBulan[date.month]} ${date.year}';
  }

  String _tanggalPilihanText() {
    if (_tanggalMasehi == null) return 'Pilih tanggal Masehi';
    return _formatTanggal(_tanggalMasehi!);
  }

  String _namaHariIndonesiaDariWeekday(int weekday) {
    const namaHari = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];

    if (weekday < 1 || weekday > 7) return '-';
    return namaHari[weekday - 1];
  }

  String _namaBulanSakaDariNomor(int bulan) {
    const bulanSaka = [
      '',
      'Chaitra',
      'Vaisakha',
      'Jyaistha',
      'Ashadha',
      'Shravana',
      'Bhadra',
      'Ashvina',
      'Kartika',
      'Agrahayana',
      'Pausa',
      'Magha',
      'Phalguna',
    ];

    if (bulan < 1 || bulan > 12) return '-';
    return bulanSaka[bulan];
  }

  bool _isGregorianLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  void _resetHasil() {
    _sudahDikonversi = false;
    _sakaHari = 0;
    _sakaBulan = 0;
    _sakaTahun = 0;
    _namaBulanSaka = '';
    _namaHariSaka = '';
    _hasilLengkapSaka = '';
  }

  void _setError(String message) {
    setState(() {
      _pesanError = message;
      _resetHasil();
    });
  }

  void _konversiTanggal() {
    if (_tanggalMasehi == null) {
      _setError('Silakan pilih tanggal terlebih dahulu');
      return;
    }

    final tanggal = _tanggalMasehi!;

    if (tanggal.isBefore(_minDate) || tanggal.isAfter(_maxDate)) {
      _setError('Tanggal harus di antara tahun 1937 sampai 2076');
      return;
    }

    try {
      final int gYear = tanggal.year;

      // Awal tahun Saka untuk tahun Gregorian saat ini
      final bool leapThisYear = _isGregorianLeapYear(gYear);
      final DateTime sakaNewYearThisGregorian =
          leapThisYear ? DateTime(gYear, 3, 21) : DateTime(gYear, 3, 22);

      int sakaYear;
      DateTime startOfSakaYear;
      bool sakaYearUsesLeapChaitra;

      if (tanggal.isBefore(sakaNewYearThisGregorian)) {
        // Masih masuk tahun Saka sebelumnya
        sakaYear = gYear - 79;
        final int prevGregorian = gYear - 1;
        final bool leapPrevGregorian = _isGregorianLeapYear(prevGregorian);
        startOfSakaYear = leapPrevGregorian
            ? DateTime(prevGregorian, 3, 21)
            : DateTime(prevGregorian, 3, 22);
        sakaYearUsesLeapChaitra = leapPrevGregorian;
      } else {
        // Sudah masuk tahun Saka baru
        sakaYear = gYear - 78;
        startOfSakaYear = sakaNewYearThisGregorian;
        sakaYearUsesLeapChaitra = leapThisYear;
      }

      final int selisihHari = tanggal.difference(startOfSakaYear).inDays;

      final List<int> panjangBulan = [
        sakaYearUsesLeapChaitra ? 31 : 30, // Chaitra
        31, // Vaisakha
        31, // Jyaistha
        31, // Ashadha
        31, // Shravana
        31, // Bhadra
        30, // Ashvina
        30, // Kartika
        30, // Agrahayana
        30, // Pausa
        30, // Magha
        30, // Phalguna
      ];

      int sisaHari = selisihHari;
      int bulanSaka = 1;
      int hariSaka = 1;

      for (int i = 0; i < panjangBulan.length; i++) {
        if (sisaHari < panjangBulan[i]) {
          bulanSaka = i + 1;
          hariSaka = sisaHari + 1;
          break;
        } else {
          sisaHari -= panjangBulan[i];
        }
      }

      final namaBulan = _namaBulanSakaDariNomor(bulanSaka);
      final namaHari = _namaHariIndonesiaDariWeekday(tanggal.weekday);

      setState(() {
        _pesanError = '';
        _sudahDikonversi = true;
        _sakaHari = hariSaka;
        _sakaBulan = bulanSaka;
        _sakaTahun = sakaYear;
        _namaBulanSaka = namaBulan;
        _namaHariSaka = namaHari;
        _hasilLengkapSaka = '$hariSaka $namaBulan $sakaYear Saka';
      });
    } catch (_) {
      _setError('Gagal mengonversi tanggal, silakan coba lagi');
    }
  }

  void _resetInputDanHasil() {
    setState(() {
      _tanggalMasehi = null;
      _pesanError = '';
      _resetHasil();
    });
  }

  Widget _infoCard(String title, String value, ColorScheme colorScheme) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Masehi ke Saka'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Konversi tanggal Masehi menjadi Kalender Saka dengan rentang tahun 1937-2076.',
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Catatan: Konversi ini menggunakan sistem Indian National Calendar (Shaka Calendar).',
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _pickTanggalMasehi,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: colorScheme.surfaceContainerLowest,
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: Row(
                  children: [
                    Icon(Icons.event, color: colorScheme.primary),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        _tanggalPilihanText(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _konversiTanggal,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Konversi ke Saka'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: _resetInputDanHasil,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Reset'),
            ),
            const SizedBox(height: 8),
            if (_pesanError.isNotEmpty)
              Text(_pesanError, style: TextStyle(color: colorScheme.error)),
            const SizedBox(height: 16),
            if (_sudahDikonversi && _pesanError.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hasil Lengkap',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _hasilLengkapSaka,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _infoCard('Hari', _sakaHari.toString(), colorScheme),
                  const SizedBox(width: 12),
                  _infoCard('Bulan', _sakaBulan.toString(), colorScheme),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _infoCard('Tahun', _sakaTahun.toString(), colorScheme),
                  const SizedBox(width: 12),
                  _infoCard('Nama Bulan', _namaBulanSaka, colorScheme),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _infoCard('Nama Hari', _namaHariSaka, colorScheme),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}