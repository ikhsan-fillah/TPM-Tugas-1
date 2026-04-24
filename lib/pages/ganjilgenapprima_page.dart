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
        pesanError =
            "Input hanya boleh bilangan bulat (tidak boleh huruf atau desimal)";
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
            Text(title, style: TextStyle(
                fontSize: 12,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            SizedBox(height: 8),
            Text(value, style: TextStyle(
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
        title: const Text("Ganjil/Genap & Prima"),
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
                  "Masukkan angka dan biarkan kami mengungkap rahasia di balik angka itu.",
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
                        keyboardType: TextInputType.number,
                        maxLength: 18,
                        decoration: InputDecoration(
                          hintText: "Masukkan angka ...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
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
                    const SizedBox(width: 12),
                    FilledButton(
                      onPressed: _cekBilangan,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(72, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Cek"),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (pesanError.isNotEmpty)
                  Text(pesanError, style: TextStyle(color: colorScheme.error)),
                const SizedBox(height: 16),
                if (angka != null)
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _infoCard("Jenis Bilangan", jenis, colorScheme),
                        const SizedBox(width: 12),
                        _infoCard("Status Prima", statusPrima, colorScheme),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
