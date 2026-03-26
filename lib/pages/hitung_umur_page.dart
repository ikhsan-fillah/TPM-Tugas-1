import 'package:flutter/material.dart';

class HitungUmurPage extends StatefulWidget {
  const HitungUmurPage({super.key});

  @override
  State<HitungUmurPage> createState() => _HitungUmurPageState();
}

class _HitungUmurPageState extends State<HitungUmurPage> {
  DateTime? _tanggalLahir;
  String _pesanError = '';
  bool _sudahDihitung = false;

  int _umurTahun = 0;
  int _umurBulan = 0;
  int _umurHari = 0;
  int _umurJam = 0;
  int _umurMenit = 0;

  void _resetHasil() {
    _umurTahun = 0;
    _umurBulan = 0;
    _umurHari = 0;
    _umurJam = 0;
    _umurMenit = 0;
    _sudahDihitung = false;
  }

  void _setError(String message) {
    setState(() {
      _pesanError = message;
      _resetHasil();
    });
  }

  Future<void> _pickTanggalLahir() async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggalLahir ?? DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (picked != null) {
      setState(() {
        _tanggalLahir = picked;
        _pesanError = '';
        _sudahDihitung = false;
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
    if (_tanggalLahir == null) return 'Pilih tanggal lahir';
    return _formatTanggal(_tanggalLahir!);
  }

  int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  void _hitungUmur() {
    if (_tanggalLahir == null) {
      _setError('Silakan pilih tanggal lahir terlebih dahulu');
      return;
    }

    try {
      final now = DateTime.now();
      final tanggalLahir = _tanggalLahir!;

      if (tanggalLahir.isAfter(now)) {
        _setError('Tanggal lahir tidak boleh lebih dari hari ini');
        return;
      }

      if (tanggalLahir.year < 1900) {
        _setError('Tahun lahir minimal 1900');
        return;
      }

      int years = now.year - tanggalLahir.year;
      int months = now.month - tanggalLahir.month;
      int days = now.day - tanggalLahir.day;

      if (days < 0) {
        final prevMonthYear = now.month == 1 ? now.year - 1 : now.year;
        final prevMonth = now.month == 1 ? 12 : now.month - 1;
        days += _daysInMonth(prevMonthYear, prevMonth);
        months -= 1;
      }

      if (months < 0) {
        months += 12;
        years -= 1;
      }

      if (years < 0) {
        _setError('Tanggal lahir tidak valid');
        return;
      }

      final duration = now.difference(
        DateTime(tanggalLahir.year, tanggalLahir.month, tanggalLahir.day),
      );

      if (duration.isNegative) {
        _setError('Terjadi kesalahan perhitungan tanggal');
        return;
      }

      setState(() {
        _pesanError = '';
        _sudahDihitung = true;
        _umurTahun = years;
        _umurBulan = (years * 12) + months;
        _umurHari = duration.inDays;
        _umurJam = duration.inHours;
        _umurMenit = duration.inMinutes;
      });
    } catch (_) {
      _setError('Terjadi kesalahan saat menghitung umur, silakan coba lagi');
    }
  }

  void _resetInputDanHasil() {
    setState(() {
      _tanggalLahir = null;
      _pesanError = '';
      _resetHasil();
    });
  }

  Widget _infoCard(String title, int value, ColorScheme colorScheme) {
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
              value.toString(),
              style: TextStyle(
                fontSize: 24,
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
        title: const Text('Hitung Umur'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hitung umur berdasarkan tanggal lahir dalam tahun, bulan, hari, jam, dan menit.',
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _pickTanggalLahir,
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
                    Icon(Icons.cake_rounded, color: colorScheme.primary),
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
              onPressed: _hitungUmur,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Hitung Umur'),
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
            if (_sudahDihitung && _pesanError.isEmpty) ...[
              Row(
                children: [
                  _infoCard('Tahun', _umurTahun, colorScheme),
                  const SizedBox(width: 12),
                  _infoCard('Bulan', _umurBulan, colorScheme),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _infoCard('Hari', _umurHari, colorScheme),
                  const SizedBox(width: 12),
                  _infoCard('Jam', _umurJam, colorScheme),
                ],
              ),
              const SizedBox(height: 12),
              Row(children: [_infoCard('Menit', _umurMenit, colorScheme)]),
            ],
          ],
        ),
      ),
    );
  }
}
