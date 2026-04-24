import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JumlahAngkaPage extends StatefulWidget {
  const JumlahAngkaPage({super.key});

  @override
  State<JumlahAngkaPage> createState() => _JumlahAngkaPageState();
}

class _JumlahAngkaPageState extends State<JumlahAngkaPage> {
  TextEditingController inputAngka = TextEditingController();

  int jumlahAngka = 0;
  int total = 0;
  String pesanError = "";

  void _hitung() {
    String text = inputAngka.text.trim();

    if (text.isEmpty) {
      setState(() {
        pesanError = "Input tidak boleh kosong";
        jumlahAngka = 0;
        total = 0;
      });
      return;
    }

    if (text.length > 10000) {
      setState(() {
        pesanError = "Input tidak boleh lebih dari 10000 karakter";
        jumlahAngka = 0;
        total = 0;
      });
      return;
    }

    final matches = RegExp(r'\d+').allMatches(text);
    final angkaList = matches.map((m) => int.parse(m.group(0)!)).toList();

    setState(() {
      if (angkaList.isEmpty) {
        pesanError = "Input harus mengandung minimal satu angka";
        jumlahAngka = 0;
        total = 0;
      } else {
        pesanError = "";
        jumlahAngka = angkaList.length;
        total = angkaList.fold(0, (sum, val) => sum + val);
      }
    });
  }

  Future<void> _pasteText() async {
    final data = await Clipboard.getData('text/plain');

    if (data != null) {
      setState(() {
        inputAngka.text = data.text ?? "";
      });
    }
  }

  void _clearText() {
    setState(() {
      inputAngka.clear();
      jumlahAngka = 0;
      total = 0;
      pesanError = "";
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
            SizedBox(height: 8),
            Text(
              value.toString(),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jumlah Angka"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Builder(
        builder: (context) {
          final colorScheme = Theme.of(context).colorScheme;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ketik kombinasi huruf dan angka, lalu lihat berapa banyak angka dan berapa total penjumlahannya.",
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: inputAngka,
                          keyboardType: TextInputType.multiline,
                          minLines: 5,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "Masukkan huruf dan angka ...",
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintStyle: const TextStyle(fontSize: 14),
                            contentPadding: const EdgeInsets.all(16),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: colorScheme.surfaceContainerLowest,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: _pasteText,
                        child: Text(
                          "Paste",
                          style: TextStyle(color: colorScheme.primary),
                        ),
                      ),
                      TextButton(
                        onPressed: _clearText,
                        child: Text(
                          "Clear",
                          style: TextStyle(color: colorScheme.primary),
                        ),
                      ),
                    ],
                  ),

                  FilledButton(
                    onPressed: _hitung,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Hitung"),
                  ),

                  SizedBox(height: 8),
                  if (pesanError.isNotEmpty)
                    Text(pesanError, style: TextStyle(color: colorScheme.error)),
                  SizedBox(height: 16),
                  if (jumlahAngka > 0)
                    Row(
                      children: [
                        _infoCard("Jumlah Angka", jumlahAngka, colorScheme),
                        const SizedBox(width: 12),
                        _infoCard("Total Penjumlahan", total, colorScheme),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}