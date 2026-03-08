import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CekBilanganPage extends StatefulWidget {
  const CekBilanganPage({super.key});

  @override
  State<CekBilanganPage> createState() => _CekBilanganPageState();
}

class _CekBilanganPageState extends State<CekBilanganPage> {
  final TextEditingController inputAngka = TextEditingController();

  int? angka;
  String jenis = "";
  String statusPrima = "";
  String pesanError = "";

  bool _isPrima(int n) {
    if (n <= 1) {
      return false;
    }

    for (int i = 2; i <= n ~/ 2; i++) {
      if (n % i == 0) {
        return false;
      }
    }

    return true;
  }

  void _cekBilangan() {
    String input = inputAngka.text.trim();

    if (input.isEmpty) {
      setState(() {
        pesanError = "Input tidak boleh kosong";
        angka = null;
      });
      return;
    }

    int? parsed = int.tryParse(input);

    if (parsed == null) {
      setState(() {
        pesanError = "Input hanya boleh bilangan bulat (tidak boleh huruf atau desimal)";
        angka = null;
      });
      return;
    }

    int n = parsed;

    setState(() {
      pesanError = "";

      angka = n;

      jenis = n % 2 == 0 ? "Genap" : "Ganjil";

      statusPrima = _isPrima(n) ? "Bilangan Prima" : "Bukan Prima";
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cek Bilangan")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Masukkan angka dan biarkan kami mengungkap rahasia di balik angka itu.",
              style: TextStyle(fontSize: 14, color: Color(0xff4A4A4A)),
            ),

            SizedBox(height: 16),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: inputAngka,
                    keyboardType: TextInputType.number,
                    maxLength: 18,
                    decoration: InputDecoration(
                      hintText: "Masukkan angka ...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFF0A0A0A))
                      ),
                      filled: true,
                      fillColor: Color(0xffffffff)
                    ),
                  ),
                ),

                SizedBox(width: 16),

                ElevatedButton(
                  onPressed: _cekBilangan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: Size(80, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                  ),
                  child: Text("Cek"),
                ),
              ],
            ),

            SizedBox(height: 16),

            if (pesanError.isNotEmpty)
              Text(pesanError, style: TextStyle(color: Colors.red)),

            SizedBox(height: 24),

            if (angka != null)
              Row(
                children: [
                  _infoCard("Jenis Bilangan", jenis),

                  SizedBox(width: 8),

                  _infoCard("Status Prima", statusPrima),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
