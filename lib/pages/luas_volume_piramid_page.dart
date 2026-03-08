import 'package:flutter/material.dart';
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

    if (panjangAlasPP.text.isEmpty || lebarAlasPP.text.isEmpty || tinggiPiramidPagePP.text.isEmpty) {
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

    if (panjangAlasS.text.isEmpty || tinggiAlasS.text.isEmpty || tinggiPiramidPageS.text.isEmpty) {
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: Text("PiramidPage")),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0XFFECECEC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SizedBox(
                  height: 32,
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
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    labelStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    labelPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 0,
                    ),
                    tabs: [
                      Tab(text: "PERSEGI"),
                      Tab(text: "PERSEGI PANJANG"),
                      Tab(text: "SEGITIGA"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  children: [_persegi(), _persegiPanjang(), _segitiga()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _persegi() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 4),
        child: Column(
          children: [
            TextField(
              controller: sisiAlasP,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text("Sisi alas (cm)"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: tinggiPiramidPageP,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text("Tinggi (cm)"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _hitungPersegi,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
              ),
              child: Text("Hitung"),
            ),

            SizedBox(height: 16),

            if (pesanError.isNotEmpty)
              Text(pesanError, style: TextStyle(color: Colors.red)),
              
            SizedBox(height: 24),

            if (volume > 0)
              Row(
                children: [
                  _infoCard("Volume", "${volume.toStringAsFixed(2)} cm³"),

                  SizedBox(width: 8),

                  _infoCard(
                    "Luas Permukaan",
                    "${luasPermukaan.toStringAsFixed(2)} cm²",
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _persegiPanjang() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 4),
        child: Column(
          children: [
            TextField(
              controller: panjangAlasPP,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text("Panjang Alas (cm)"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: lebarAlasPP,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text("Lebar Alas (cm)"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: tinggiPiramidPagePP,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text("Tinggi (cm)"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _hitungPersegiPanjang,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
              ),
              child: Text("Hitung"),
            ),
            SizedBox(height: 16),

            if (pesanError.isNotEmpty)
              Text(pesanError, style: TextStyle(color: Colors.red)),
              
            SizedBox(height: 24),

            if (volume > 0)
              Row(
                children: [
                  _infoCard("Volume", "${volume.toStringAsFixed(2)} cm³"),

                  SizedBox(width: 8),

                  _infoCard(
                    "Luas Permukaan",
                    "${luasPermukaan.toStringAsFixed(2)} cm²",
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _segitiga() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 4),
        child: Column(
          children: [
            TextField(
              controller: panjangAlasS,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text("Panjang Alas (cm)"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: tinggiAlasS,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text("Tinggi Alas (cm)"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: tinggiPiramidPageS,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text("Tinggi (cm)"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _hitungSegitiga,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
              ),
              child: Text("Hitung"),
            ),

            SizedBox(height: 16),

            if (pesanError.isNotEmpty)
              Text(pesanError, style: TextStyle(color: Colors.red)),
              
            SizedBox(height: 24),

            if (volume > 0)
              Row(
                children: [
                  _infoCard("Volume", "${volume.toStringAsFixed(2)} cm³"),

                  SizedBox(width: 8),

                  _infoCard(
                    "Luas Permukaan",
                    "${luasPermukaan.toStringAsFixed(2)} cm²",
                  ),
                ],
              ),
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
