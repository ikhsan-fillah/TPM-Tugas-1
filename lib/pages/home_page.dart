import 'package:flutter/material.dart';
import 'package:tugas_1/pages/data_kelompok_page.dart';
import 'package:tugas_1/pages/ganjilgenapprima_page.dart';
import 'package:tugas_1/pages/jumlah_total_angka_page.dart';
import 'package:tugas_1/pages/login_page.dart';
import 'package:tugas_1/pages/penjumlahan_pengurangan_page.dart';
import 'package:tugas_1/pages/stopwatch_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Matematika Bahagia"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Anggota Kelompok:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "Ahmad Zainur Fadli - 123200049",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      "Ikhsan Fillah Hidayat - 123230219",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.1,
                children: [
                  _buildCard(icon: Icons.person, title: 'Data Kelompok', onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DataKelompokPage(),
                      ),
                    );
                  }),
                  _buildCard(
                    icon: Icons.calculate,
                    title: 'Penjumlahan & Pengurangan',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PenjumlahanPenguranganPage(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    icon: Icons.school,
                    title: 'Ganjil/Genap & Prima',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const CekBilanganPage(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    icon: Icons.functions,
                    title: 'Jumlah Total Angka',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const JumlahAngkaPage(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    icon: Icons.bar_chart,
                    title: 'Stopwatch',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const StopwatchPage(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    icon: Icons.bar_chart,
                    title: 'Luas & Volume Piramid',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCard({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            const SizedBox(height: 10),
            Text(title),
          ],
        ),
      ),
    ),
  );
}
