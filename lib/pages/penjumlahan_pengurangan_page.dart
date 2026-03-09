import 'package:flutter/material.dart';

class PenjumlahanPenguranganPage extends StatefulWidget {
  const PenjumlahanPenguranganPage({super.key});

  @override
  State<PenjumlahanPenguranganPage> createState() =>
      _PenjumlahanPenguranganPageState();
}

class _PenjumlahanPenguranganPageState
    extends State<PenjumlahanPenguranganPage> {
  final TextEditingController _angka1Controller = TextEditingController();
  final TextEditingController _angka2Controller = TextEditingController();
  String hasil = "";
  String operasi = "Penjumlahan";

  void _hitung() {
    final String input1 = _angka1Controller.text.trim();
    final String input2 = _angka2Controller.text.trim();

    if (input1.isEmpty || input2.isEmpty) {
      setState(() {
        hasil = 'Input tidak boleh kosong';
      });
      return;
    }

    final double? angka1 = double.tryParse(input1);
    final double? angka2 = double.tryParse(input2);

    if (angka1 == null || angka2 == null) {
      setState(() {
        hasil = 'Input harus berupa angka';
      });
      return;
    }

    double result;
    if (operasi == 'Penjumlahan') {
      result = angka1 + angka2;
      setState(() {
        hasil = '$angka1 + $angka2 = $result';
      });
    } else {
      result = angka1 - angka2;
      setState(() {
        hasil = '$angka1 - $angka2 = $result';
      });
    }

    setState(() {
      hasil = result.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penjumlahan & Pengurangan'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 0,
            color: colorScheme.surfaceContainerLow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kalkulator',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Masukkan dua angka untuk dihitung',
                    style: TextStyle(
                      fontSize: 13,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _angka1Controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Angka Pertama',
                      prefixIcon: const Icon(Icons.looks_one_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
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
                  const SizedBox(height: 16),
                  TextField(
                    controller: _angka2Controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Angka Kedua',
                      prefixIcon: const Icon(Icons.looks_two_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
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
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {
                            setState(() {
                              operasi = 'Penjumlahan';
                            });
                            _hitung();
                          },
                          icon: const Icon(Icons.add_rounded),
                          label: const Text('Jumlah'),
                          style: FilledButton.styleFrom(
                            backgroundColor: operasi == 'Penjumlahan'
                                ? colorScheme.primary
                                : colorScheme.surfaceContainerHigh,
                            foregroundColor: operasi == 'Penjumlahan'
                                ? colorScheme.onPrimary
                                : colorScheme.onSurface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {
                            setState(() {
                              operasi = 'Pengurangan';
                            });
                            _hitung();
                          },
                          icon: const Icon(Icons.remove_rounded),
                          label: const Text('Kurang'),
                          style: FilledButton.styleFrom(
                            backgroundColor: operasi == 'Pengurangan'
                                ? colorScheme.primary
                                : colorScheme.surfaceContainerHigh,
                            foregroundColor: operasi == 'Pengurangan'
                                ? colorScheme.onPrimary
                                : colorScheme.onSurface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (hasil.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hasil',
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            hasil,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
