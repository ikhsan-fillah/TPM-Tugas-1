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
    return Scaffold(
      appBar: AppBar(title: const Text('Penjumlahan & Pengurangan')),
      body: Center(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Padding(padding: const EdgeInsets.all(24), child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Masukkan Angka',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),  
              const SizedBox(height: 20),
              TextField(
                controller: _angka1Controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Angka Pertama',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _angka2Controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Angka Kedua',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        operasi = 'Penjumlahan';
                      });
                      _hitung();
                    },
                    child: const Text('Penjumlahan'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        operasi = 'Pengurangan';
                      });
                      _hitung();
                    },
                    child: const Text('Pengurangan'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                hasil,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
