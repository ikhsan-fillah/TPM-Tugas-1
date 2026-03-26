import 'package:flutter/material.dart';
import 'package:tugas_1/pages/cek_hari_weton_page.dart';
import 'package:tugas_1/pages/data_kelompok_page.dart';
import 'package:tugas_1/pages/ganjilgenapprima_page.dart';
import 'package:tugas_1/pages/jumlah_total_angka_page.dart';
import 'package:tugas_1/pages/login1_page.dart';
import 'package:tugas_1/pages/penjumlahan_pengurangan_page.dart';
import 'package:tugas_1/pages/stopwatch_page.dart';
import 'package:tugas_1/pages/luas_volume_piramid_page.dart';
import 'package:tugas_1/pages/hitung_umur_page.dart';
import 'package:tugas_1/pages/konversi_hijriah_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Matematika Bahagia"),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Login1Page()),
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
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.group_rounded,
                          color: colorScheme.onPrimaryContainer,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Anggota Kelompok",
                          style: TextStyle(
                            color: colorScheme.onPrimaryContainer,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      "Ahmad Zainur Fadli — 123200049",
                      style: TextStyle(
                        color: colorScheme.onPrimaryContainer,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      "Ikhsan Fillah Hidayat — 123230219",
                      style: TextStyle(
                        color: colorScheme.onPrimaryContainer,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
                children: [
                  _buildCard(
                    icon: Icons.person_rounded,
                    title: 'Data Kelompok',
                    colorScheme: colorScheme,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DataKelompokPage(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    icon: Icons.calculate_rounded,
                    title: 'Penjumlahan & Pengurangan',
                    colorScheme: colorScheme,
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
                    icon: Icons.filter_1_rounded,
                    title: 'Ganjil/Genap & Prima',
                    colorScheme: colorScheme,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CekBilanganPage(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    icon: Icons.functions_rounded,
                    title: 'Jumlah Angka',
                    colorScheme: colorScheme,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const JumlahAngkaPage(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    icon: Icons.timer_rounded,
                    title: 'Stopwatch',
                    colorScheme: colorScheme,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StopwatchPage(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    icon: Icons.architecture_rounded,
                    title: 'Luas & Volume Piramid',
                    colorScheme: colorScheme,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PiramidPage(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    icon: Icons.calendar_today,
                    title: 'Hari & Weton',
                    colorScheme: colorScheme,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CekHariWetonPage(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    icon: Icons.cake_rounded,
                    title: 'Hitung Umur',
                    colorScheme: colorScheme,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HitungUmurPage(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    icon: Icons.mosque_rounded,
                    title: 'Masehi ke Hijriah',
                    colorScheme: colorScheme,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const KonversiHijriahPage(),
                        ),
                      );
                    },
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
  required ColorScheme colorScheme,
}) {
  return Card(
    clipBehavior: Clip.antiAlias,
    elevation: 0,
    color: colorScheme.surfaceContainerLow,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 28,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
