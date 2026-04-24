import 'package:flutter/material.dart';

class KonversiSakaPage extends StatefulWidget {
  const KonversiSakaPage({super.key});

  @override
  State<KonversiSakaPage> createState() => _KonversiSakaPageState();
}

class _KonversiSakaPageState extends State<KonversiSakaPage> {

  // DATA NYEPI
  static final List<_DataNyepi> _dataNyepi = [
    _DataNyepi(DateTime(2000, 3, 7), 1922),
    _DataNyepi(DateTime(2001, 3, 26), 1923),
    _DataNyepi(DateTime(2002, 3, 15), 1924),
    _DataNyepi(DateTime(2003, 3, 4), 1925),
    _DataNyepi(DateTime(2004, 3, 22), 1926),
    _DataNyepi(DateTime(2005, 3, 11), 1927),
    _DataNyepi(DateTime(2006, 3, 30), 1928),
    _DataNyepi(DateTime(2007, 3, 19), 1929),
    _DataNyepi(DateTime(2008, 3, 7), 1930),
    _DataNyepi(DateTime(2009, 3, 26), 1931),
    _DataNyepi(DateTime(2010, 3, 16), 1932),
    _DataNyepi(DateTime(2011, 3, 5), 1933),
    _DataNyepi(DateTime(2012, 3, 23), 1934),
    _DataNyepi(DateTime(2013, 3, 12), 1935),
    _DataNyepi(DateTime(2014, 3, 31), 1936),
    _DataNyepi(DateTime(2015, 3, 21), 1937),
    _DataNyepi(DateTime(2016, 3, 9), 1938),
    _DataNyepi(DateTime(2017, 3, 28), 1939),
    _DataNyepi(DateTime(2018, 3, 17), 1940),
    _DataNyepi(DateTime(2019, 3, 7), 1941),
    _DataNyepi(DateTime(2020, 3, 25), 1942),
    _DataNyepi(DateTime(2021, 3, 14), 1943),
    _DataNyepi(DateTime(2022, 3, 3), 1944),
    _DataNyepi(DateTime(2023, 3, 22), 1945),
    _DataNyepi(DateTime(2024, 3, 11), 1946),
    _DataNyepi(DateTime(2025, 3, 29), 1947),
    _DataNyepi(DateTime(2026, 3, 19), 1948),
    _DataNyepi(DateTime(2027, 3, 8), 1949),
    _DataNyepi(DateTime(2028, 3, 26), 1950),
    _DataNyepi(DateTime(2029, 3, 15), 1951),
    _DataNyepi(DateTime(2030, 3, 5), 1952),
  ];

  static const List<String> _namaSasih = [
    'Kasa','Karo','Katiga','Kapat','Kalima','Kanem',
    'Kapitu','Kawolu','Kasanga','Kadasa','Desta','Sada',
    'Kanem Nampih'
  ];

  DateTime? _tanggal;
  String _error = '';
  bool _converted = false;

  int hari = 0;
  int bulan = 0;
  int tahun = 0;
  String namaBulan = '';
  String namaHari = '';
  String hasilLengkap = '';

  static final DateTime _minDate = DateTime(2000);
  static final DateTime _maxDate = DateTime(2030, 12, 31);

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: _minDate,
      lastDate: _maxDate,
    );

    if (picked != null) {
      setState(() {
        _tanggal = picked;
        _converted = false;
        _error = '';
      });
    }
  }

  String _saptawara(int w) {
    const d = ['Soma','Anggara','Buda','Wraspati','Sukra','Saniscara','Redite'];
    return d[w - 1];
  }

  String _tanggalText() {
    if (_tanggal == null) return "Pilih tanggal Masehi";
    return "${_tanggal!.day} ${_bulanNama(_tanggal!.month)} ${_tanggal!.year}";
  }

  String _bulanNama(int m) {
    const b = [
      '', 'Januari','Februari','Maret','April','Mei','Juni',
      'Juli','Agustus','September','Oktober','November','Desember'
    ];
    return b[m];
  }

  // PANJANG SASIH (FIX 29/30 + KABISAT)
  List<int> _panjangSasih(int jumlahSasih) {
    List<int> hasil = [];

    for (int i = 0; i < jumlahSasih; i++) {
      hasil.add(i.isEven ? 30 : 29);
    }

    if (jumlahSasih == 13) {
      hasil.insert(6, 30);
    }

    return hasil;
  }

  void _konversi() {
    if (_tanggal == null) {
      setState(() => _error = "Silakan pilih tanggal terlebih dahulu");
      return;
    }

    final tgl = _tanggal!;

    _DataNyepi? nyepiAwal;
    _DataNyepi? nyepiBerikut;

    for (int i = 0; i < _dataNyepi.length; i++) {
      final n = _dataNyepi[i];
      if (!tgl.isBefore(n.tanggal)) {
        nyepiAwal = n;
        if (i + 1 < _dataNyepi.length) {
          nyepiBerikut = _dataNyepi[i + 1];
        }
      }
    }

    if (nyepiAwal == null || nyepiBerikut == null) {
      setState(() => _error = "Data tidak tersedia");
      return;
    }

    int selisih = tgl.difference(nyepiAwal.tanggal).inDays;
    int totalHari = nyepiBerikut.tanggal.difference(nyepiAwal.tanggal).inDays;

    int jumlahSasih = totalHari > 360 ? 13 : 12;

    List<int> panjang = _panjangSasih(jumlahSasih);

    int sasih = 0;
    int sisa = selisih;

    for (int i = 0; i < panjang.length; i++) {
      if (sisa < panjang[i]) {
        sasih = i;
        break;
      }
      sisa -= panjang[i];
    }

    int tglSaka;
    String fase;

    if (sisa < 15) {
      fase = "Penanggal";
      tglSaka = sisa + 1;
    } else {
      fase = "Panglong";
      tglSaka = sisa - 14;
    }

    setState(() {
      _converted = true;
      _error = '';

      hari = tglSaka;
      bulan = sasih + 1;
      tahun = nyepiAwal!.tahunSaka;
      namaBulan = _namaSasih[sasih];
      namaHari = _saptawara(tgl.weekday);

      hasilLengkap =
          "$namaHari, $fase $tglSaka $namaBulan $tahun Saka";
    });
  }

  void _reset() {
    setState(() {
      _tanggal = null;
      _converted = false;
      _error = '';
    });
  }

  Widget _card(String title, String value, ColorScheme olorScheme) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: olorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 12, color: olorScheme.onPrimaryContainer)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final olorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Masehi ke Saka Bali'),
        backgroundColor: olorScheme.primary,
        foregroundColor: olorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Konversi tanggal Masehi menjadi Kalender Saka Bali",
                style: TextStyle(color: olorScheme.onSurfaceVariant)),

            const SizedBox(height: 16),

            InkWell(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: olorScheme.outlineVariant),
                ),
                child: Row(
                  children: [
                    Icon(Icons.event, color: olorScheme.primary),
                    const SizedBox(width: 12),
                    Text(_tanggalText()),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            FilledButton(
              onPressed: _konversi,
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              child: const Text("Konversi ke Saka"),
            ),

            const SizedBox(height: 8),

            OutlinedButton(
              onPressed: _reset,
              style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              child: const Text("Reset"),
            ),

            if (_error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(_error, style: TextStyle(color: olorScheme.error)),
              ),

            if (_converted) ...[
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: olorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Hasil Lengkap"),
                    const SizedBox(height: 8),
                    Text(hasilLengkap,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  _card("Hari", hari.toString(), olorScheme),
                  const SizedBox(width: 12),
                  _card("Bulan", bulan.toString(), olorScheme),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  _card("Tahun", tahun.toString(), olorScheme),
                  const SizedBox(width: 12),
                  _card("Nama Bulan", namaBulan, olorScheme),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  _card("Nama Hari", namaHari, olorScheme),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class _DataNyepi {
  final DateTime tanggal;
  final int tahunSaka;
  const _DataNyepi(this.tanggal, this.tahunSaka);
}