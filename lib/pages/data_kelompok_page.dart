import 'package:flutter/material.dart';

class DataKelompokPage extends StatelessWidget {
  const DataKelompokPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Kelompok')),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.group, size: 60, color: Colors.blue),
            const SizedBox(height: 16),
            const Text(
              "Anggota Kelompok:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24.0),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text("1", style: TextStyle(color: Colors.white)),
                    ),
                    title: const Text("Ahmad Zainur Fadli"),
                    subtitle: const Text("123200035"),
                  ),
                  Divider(),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text("1", style: TextStyle(color: Colors.white)),
                    ),
                    title: const Text("Ikhsan Fillah Hidayat"),
                    subtitle: const Text("123230219"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
