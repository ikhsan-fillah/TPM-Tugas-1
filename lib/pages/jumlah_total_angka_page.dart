import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JumlahAngkaPage extends StatefulWidget {
  const JumlahAngkaPage({super.key});

  @override
  State<JumlahAngkaPage> createState() => _JumlahAngkaPageState();
}

class _JumlahAngkaPageState extends State<JumlahAngkaPage> {
  TextEditingController inputAngka = TextEditingController();

  int jumlahDigit = 0;
  int total = 0;
  String pesanError = "";

  void hitung() {
    String text = inputAngka.text.trim();

    if (text.isEmpty) {
      setState(() {
        pesanError = "Input tidak boleh kosong";
        jumlahDigit = 0;
        total = 0;
      });
      return;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(text)) {
      setState(() {
        pesanError =
            "Input hanya boleh bilangan bulat (tidak boleh huruf atau desimal)";
        jumlahDigit = 0;
        total = 0;
      });
      return;
    }

    if (text.length > 10000) {
      setState(() {
        pesanError = "Digit tidak boleh lebih dari 10000";
        jumlahDigit = 0;
        total = 0;
      });
      return;
    }

    jumlahDigit = text.length;
    total = 0;

    for (int i = 0; i < text.length; i++) {
      total += int.parse(text[i]);
    }

    setState(() {
      pesanError = "";
    });
  }

  Future<void> pasteText() async {
    final data = await Clipboard.getData('text/plain');

    if (data != null) {
      setState(() {
        inputAngka.text = data.text ?? "";
      });
    }
  }

  void clearText() {
    setState(() {
      inputAngka.clear();
      jumlahDigit = 0;
      total = 0;
      pesanError = "";
    });
  }

  Widget infoCard(String title, int value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 6),

          Text(
            value.toString(),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jumlah Angka")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ketik angka apa saja, lalu lihat berapa banyak digit dan berapa totalnya.",
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
                    decoration: InputDecoration(
                      hintText: "Masukkan angka ...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFF0A0A0A)),
                      ),
                      filled: true,
                      fillColor: Color(0xffffffff),
                    ),
                  ),
                ),

                SizedBox(width: 16),

                ElevatedButton(
                  onPressed: hitung,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: Size(80, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                  ),
                  child: Text("Hitung"),
                ),
              ],
            ),

            Row(
              children: [
                TextButton(
                  onPressed: pasteText,
                  child: Text("Paste", style: TextStyle(
                    color: Color(0xff2563A8)
                  ),),
                ),

                TextButton(
                  onPressed: clearText,
                  child: Text("Clear", style: TextStyle(
                    color: Color(0xff2563A8)
                  ),),
                ),
              ],
            ),

            SizedBox(height: 16),

            if (pesanError.isNotEmpty)
              Text(pesanError, style: TextStyle(color: Colors.red)),

            SizedBox(height: 24),

            if (jumlahDigit > 0)
              Row(
                children: [
                  infoCard("Jumlah Digit", jumlahDigit),

                  SizedBox(width: 8),

                  infoCard("Total Penjumlahan", total),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
