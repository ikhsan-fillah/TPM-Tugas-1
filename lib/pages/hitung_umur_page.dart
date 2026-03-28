import 'dart:async';

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
  Timer? _timerRealtime;

  int _umurTahun = 0;
  int _umurBulan = 0;
  int _umurHari = 0;
  int _umurJam = 0;
  int _umurMenit = 0;
  int _umurDetik = 0;

  int get _umurDetikAman => ((this as dynamic)._umurDetik as int?) ?? 0;

  void _stopRealtimeUpdate() {
    _timerRealtime?.cancel();
    _timerRealtime = null;
  }

  void _startRealtimeUpdate() {
    _stopRealtimeUpdate();
    _timerRealtime = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || !_sudahDihitung || _tanggalLahir == null) {
        return;
      }
      _hitungUmur(startRealtime: false);
    });
  }

  void _resetHasil() {
    _stopRealtimeUpdate();
    _umurTahun = 0;
    _umurBulan = 0;
    _umurHari = 0;
    _umurJam = 0;
    _umurMenit = 0;
    _umurDetik = 0;
    _sudahDihitung = false;
  }

  void _setError(String message) {
    if (!mounted) return;
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

    if (!mounted) return;

    if (picked != null) {
      _stopRealtimeUpdate();
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

  void _hitungUmur({bool startRealtime = true}) {
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
      int hours = now.hour;
      int minutes = now.minute;
      int seconds = now.second;

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

      setState(() {
        _pesanError = '';
        _sudahDihitung = true;
        _umurTahun = years;
        _umurBulan = months;
        _umurHari = days;
        _umurJam = hours;
        _umurMenit = minutes;
        _umurDetik = seconds;
      });

      if (startRealtime) {
        _startRealtimeUpdate();
      }
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

  @override
  void reassemble() {
    super.reassemble();
    (this as dynamic)._umurDetik ??= 0;
  }

  @override
  void dispose() {
    _stopRealtimeUpdate();
    super.dispose();
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
              'Hitung umur berdasarkan tanggal lahir dalam tahun, bulan, hari, jam, menit, dan detik.',
              style: TextStyle(fontSize: 14, color: colorScheme.onSurface),
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
                  color: colorScheme.surface,
                  border: Border.all(color: colorScheme.outline),
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
                        fontSize: 14,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$_umurTahun tahun $_umurBulan bulan $_umurHari hari $_umurJam jam $_umurMenit menit $_umurDetikAman detik',
                      style: TextStyle(
                        fontSize: 18,
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
                  _infoCard('Tahun', _umurTahun.toString(), colorScheme),
                  const SizedBox(width: 12),
                  _infoCard('Bulan', _umurBulan.toString(), colorScheme),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _infoCard('Hari', _umurHari.toString(), colorScheme),
                  const SizedBox(width: 12),
                  _infoCard('Jam', _umurJam.toString(), colorScheme),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _infoCard('Menit', _umurMenit.toString(), colorScheme),
                  const SizedBox(width: 12),
                  _infoCard('Detik', _umurDetikAman.toString(), colorScheme),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
