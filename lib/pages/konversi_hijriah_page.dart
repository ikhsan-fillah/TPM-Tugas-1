import 'package:flutter/material.dart';
import 'package:hijri_calendar/hijri_calendar.dart';

class KonversiHijriahPage extends StatefulWidget {
  const KonversiHijriahPage({super.key});

  @override
  State<KonversiHijriahPage> createState() => _KonversiHijriahPageState();
}

class _KonversiHijriahPageState extends State<KonversiHijriahPage> {
  static final DateTime _minDate = DateTime(1937, 1, 1);
  static final DateTime _maxDate = DateTime(2076, 12, 31);

  DateTime? _tanggalMasehi;
  String _pesanError = '';
  bool _sudahDikonversi = false;

  int _hijriahHari = 0;
  int _hijriahBulan = 0;
  int _hijriahTahun = 0;
  String _namaBulanHijriah = '';
  String _namaHariHijriah = '';
  String _hasilLengkapHijriah = '';

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

  void _resetHasil() {
    _sudahDikonversi = false;
    _hijriahHari = 0;
    _hijriahBulan = 0;
    _hijriahTahun = 0;
    _namaBulanHijriah = '';
    _namaHariHijriah = '';
    _hasilLengkapHijriah = '';
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
      HijriCalendarConfig.language = 'en';
      final hijriah = HijriCalendarConfig.fromGregorian(tanggal);

      setState(() {
        _pesanError = '';
        _sudahDikonversi = true;
        _hijriahHari = hijriah.hDay;
        _hijriahBulan = hijriah.hMonth;
        _hijriahTahun = hijriah.hYear;
        _namaBulanHijriah = hijriah.getLongMonthName();
        _namaHariHijriah = _namaHariIndonesiaDariWeekday(tanggal.weekday);
        _hasilLengkapHijriah =
            '${hijriah.hDay} ${hijriah.getLongMonthName()} ${hijriah.hYear} H';
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
        title: const Text('Masehi ke Hijriah'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Konversi tanggal Masehi menjadi tanggal Hijriah dengan rentang tahun 1937-2076.',
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
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
              child: const Text('Konversi ke Hijriah'),
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
                      _hasilLengkapHijriah,
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
                  _infoCard('Hari', _hijriahHari.toString(), colorScheme),
                  const SizedBox(width: 12),
                  _infoCard('Bulan', _hijriahBulan.toString(), colorScheme),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _infoCard('Tahun', _hijriahTahun.toString(), colorScheme),
                  const SizedBox(width: 12),
                  _infoCard('Nama Bulan', _namaBulanHijriah, colorScheme),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _infoCard('Nama Hari', _namaHariHijriah, colorScheme),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
