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

  void _hitung() {
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
      jumlahDigit = 0;
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
            Text(title, style: TextStyle(
                fontSize: 12,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            SizedBox(height: 8),
            Text(value.toString(), style: TextStyle(
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
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ketik angka apa saja, lalu lihat berapa banyak digit dan berapa totalnya.",
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
                          hintText: "Masukkan angka ...",
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
                if (jumlahDigit > 0)
                  Row(
                    children: [
                      _infoCard("Jumlah Digit", jumlahDigit, colorScheme),
                      const SizedBox(width: 12),
                      _infoCard("Total Penjumlahan", total, colorScheme),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
