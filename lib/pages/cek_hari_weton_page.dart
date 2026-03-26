import 'package:flutter/material.dart';

class CekHariWetonPage extends StatefulWidget {
  const CekHariWetonPage({super.key});

  @override
  State<CekHariWetonPage> createState() => _CekHariWetonPageState();
}

class _CekHariWetonPageState extends State<CekHariWetonPage> {
  DateTime? selectedDate;

  String namaHari = "";
  String namaPasaran = "";
  String hasilWeton = "";
  String pesanError = "";

  final List<String> hariList = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Minggu",
  ];

  final List<String> pasaranList = [
    "Legi",
    "Pahing",
    "Pon",
    "Wage",
    "Kliwon",
  ];

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        pesanError = "";
        namaHari = "";
        namaPasaran = "";
        hasilWeton = "";
      });
    }
  }

  String _formatTanggal(DateTime date) {
    List<String> namaBulan = [
      "",
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember",
    ];

    return "${date.day} ${namaBulan[date.month]} ${date.year}";
  }

  void _cekHariWeton() {
    if (selectedDate == null) {
      setState(() {
        pesanError = "Silakan pilih tanggal terlebih dahulu";
        namaHari = "";
        namaPasaran = "";
        hasilWeton = "";
      });
      return;
    }

    final date = selectedDate!;
    final hari = hariList[date.weekday - 1];

    // Acuan pasaran, 17 Agustus 1945 = Jumat Legi
    final DateTime tanggalAcuan = DateTime(1945, 8, 17);
    final int selisihHari = date.difference(tanggalAcuan).inDays;

    int indexPasaran = selisihHari % 5;
    if (indexPasaran < 0) indexPasaran += 5;

    final pasaran = pasaranList[indexPasaran];

    setState(() {
      namaHari = hari;
      namaPasaran = pasaran;
      hasilWeton = "$hari $pasaran";
      pesanError = "";
    });
  }

  void _resetInputDanHasil() {
    setState(() {
      selectedDate = null;
      namaHari = "";
      namaPasaran = "";
      hasilWeton = "";
      pesanError = "";
    });
  }

  Widget _halfInfoCard(String title, String value, ColorScheme colorScheme) {
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

  Widget _fullInfoCard(String title, String value, ColorScheme colorScheme) {
    return Container(
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
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  String _tanggalPilihanText() {
    if (selectedDate == null) return "Pilih tanggal";
    return _formatTanggal(selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hari & Weton"),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Temukan hari, pasaran, dan weton Jawa berdasarkan tanggal pilihanmu.",
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 16),

            InkWell(
              onTap: _pickDate,
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
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(_tanggalPilihanText(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            FilledButton(
              onPressed: _cekHariWeton,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text("Cek Hari & Weton"),
            ),
            SizedBox(height: 8),
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

            SizedBox(height: 8),

            if (pesanError.isNotEmpty)
              Text(
                pesanError,
                style: TextStyle(color: colorScheme.error),
              ),

            SizedBox(height: 16),

            if (hasilWeton.isNotEmpty) ...[
              Row(
                children: [
                  _halfInfoCard("Hari", namaHari, colorScheme),
                  SizedBox(width: 16),
                  _halfInfoCard("Pasaran", namaPasaran, colorScheme),
                ],
              ),
              SizedBox(height: 16),
              _fullInfoCard("Weton", hasilWeton, colorScheme),
            ],
          ],
        ),
      ),
    );
  }
}