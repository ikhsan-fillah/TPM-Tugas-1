import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class PiramidPage extends StatefulWidget {
  const PiramidPage({super.key});

  @override
  State<PiramidPage> createState() => _PiramidPageState();
}

class _PiramidPageState extends State<PiramidPage> {
  final sisiAlasP = TextEditingController();
  final tinggiPiramidPageP = TextEditingController();

  final panjangAlasPP = TextEditingController();
  final lebarAlasPP = TextEditingController();
  final tinggiPiramidPagePP = TextEditingController();

  final panjangAlasS = TextEditingController();
  final tinggiAlasS = TextEditingController();
  final tinggiPiramidPageS = TextEditingController();

  double volume = 0;
  double luasPermukaan = 0;
  String pesanError = "";

  void _hitungPersegi() {
    if (sisiAlasP.text.isEmpty || tinggiPiramidPageP.text.isEmpty) {
      setState(() {
        pesanError = "Input tidak boleh kosong";
        volume = 0;
        luasPermukaan = 0;
      });
      return;
    }

    double? s = double.tryParse(sisiAlasP.text);
    double? t = double.tryParse(tinggiPiramidPageP.text);

    if (s == null || t == null) {
      setState(() {
        pesanError = "Input harus berupa angka";
        volume = 0;
        luasPermukaan = 0;
      });
      return;
    }

    double ts = sqrt(pow(s / 2, 2) + pow(t, 2));

    setState(() {
      pesanError = "";
      volume = (1 / 3) * s * s * t;
      luasPermukaan = (s * s) + 4 * (0.5 * s * ts);
    });
  }

  void _hitungPersegiPanjang() {
    if (panjangAlasPP.text.isEmpty ||
        lebarAlasPP.text.isEmpty ||
        tinggiPiramidPagePP.text.isEmpty) {
      setState(() {
        pesanError = "Input tidak boleh kosong";
        volume = 0;
        luasPermukaan = 0;
      });
      return;
    }

    double? p = double.tryParse(panjangAlasPP.text);
    double? l = double.tryParse(lebarAlasPP.text);
    double? t = double.tryParse(tinggiPiramidPagePP.text);

    if (p == null || l == null || t == null) {
      setState(() {
        pesanError = "Input harus berupa angka";
        volume = 0;
        luasPermukaan = 0;
      });
      return;
    }

    double ts = sqrt(pow(l / 2, 2) + pow(t, 2));

    setState(() {
      pesanError = "";
      volume = (1 / 3) * (p * l) * t;
      luasPermukaan = (p * l) + 2 * (p * ts) + 2 * (l * ts);
    });
  }

  void _hitungSegitiga() {
    if (panjangAlasS.text.isEmpty ||
        tinggiAlasS.text.isEmpty ||
        tinggiPiramidPageS.text.isEmpty) {
      setState(() {
        pesanError = "Input tidak boleh kosong";
        volume = 0;
        luasPermukaan = 0;
      });
      return;
    }
    double? a = double.tryParse(panjangAlasS.text);
    double? ta = double.tryParse(tinggiAlasS.text);
    double? t = double.tryParse(tinggiPiramidPageS.text);

    if (a == null || ta == null || t == null) {
      setState(() {
        pesanError = "Input harus berupa angka";
        volume = 0;
        luasPermukaan = 0;
      });
      return;
    }

    double luasAlas = 0.5 * a * ta;

    setState(() {
      pesanError = "";
      volume = (1 / 3) * luasAlas * t;
      luasPermukaan = luasAlas + (3 * (0.5 * a * t));
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Luas & Volume Piramid"),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: 36,
                  child: TabBar(
                    onTap: (index) {
                      setState(() {
                        volume = 0;
                        luasPermukaan = 0;
                        pesanError = "";
                      });
                    },
                    dividerColor: Colors.transparent,
                    isScrollable: false,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    labelStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                    labelColor: colorScheme.onPrimary,
                    unselectedLabelColor: colorScheme.onSurfaceVariant,
                    labelPadding: EdgeInsets.zero,
                    tabs: const [
                      Tab(text: "PERSEGI"),
                      Tab(text: "PERSEGI PANJANG"),
                      Tab(text: "SEGITIGA"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  children: [
                    _persegi(colorScheme),
                    _persegiPanjang(colorScheme),
                    _segitiga(colorScheme),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController ctrl, String label, ColorScheme cs) {
    return TextField(
      controller: ctrl,
      keyboardType: TextInputType.number,
      maxLength: 10,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
      ],
      decoration: InputDecoration(
        label: Text(label),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.primary, width: 2),
        ),
        filled: true,
        fillColor: cs.surfaceContainerLowest,
      ),
    );
  }

  Widget _hitungButton(VoidCallback onPressed, ColorScheme cs) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text("Hitung"),
    );
  }

  Widget _resultRow(ColorScheme cs) {
    return Row(
      children: [
        _infoCard("Volume", "${volume.toStringAsFixed(2)} cm³"),
        const SizedBox(width: 12),
        _infoCard("Luas Permukaan", "${luasPermukaan.toStringAsFixed(2)} cm²"),
      ],
    );
  }

  Widget _persegi(ColorScheme cs) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildField(sisiAlasP, "Sisi alas (cm)", cs),
            const SizedBox(height: 8),
            _buildField(tinggiPiramidPageP, "Tinggi (cm)", cs),
            const SizedBox(height: 16),
            _hitungButton(_hitungPersegi, cs),
            const SizedBox(height: 16),
            if (pesanError.isNotEmpty)
              Text(pesanError, style: TextStyle(color: cs.error)),
            if (volume > 0) _resultRow(cs),
          ],
        ),
      ),
    );
  }

  Widget _persegiPanjang(ColorScheme cs) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildField(panjangAlasPP, "Panjang Alas (cm)", cs),
            const SizedBox(height: 8),
            _buildField(lebarAlasPP, "Lebar Alas (cm)", cs),
            const SizedBox(height: 8),
            _buildField(tinggiPiramidPagePP, "Tinggi (cm)", cs),
            const SizedBox(height: 16),
            _hitungButton(_hitungPersegiPanjang, cs),
            const SizedBox(height: 16),
            if (pesanError.isNotEmpty)
              Text(pesanError, style: TextStyle(color: cs.error)),
            if (volume > 0) _resultRow(cs),
          ],
        ),
      ),
    );
  }

  Widget _segitiga(ColorScheme cs) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildField(panjangAlasS, "Panjang Alas (cm)", cs),
            const SizedBox(height: 8),
            _buildField(tinggiAlasS, "Tinggi Alas (cm)", cs),
            const SizedBox(height: 8),
            _buildField(tinggiPiramidPageS, "Tinggi (cm)", cs),
            const SizedBox(height: 16),
            _hitungButton(_hitungSegitiga, cs),
            const SizedBox(height: 16),
            if (pesanError.isNotEmpty)
              Text(pesanError, style: TextStyle(color: cs.error)),
            if (volume > 0) _resultRow(cs),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
