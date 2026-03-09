import 'package:flutter/material.dart';

class DataKelompokPage extends StatelessWidget {
  const DataKelompokPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Kelompok'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildExpandCard(
              image: 'assets/images/anggota1.jpg',
              nama: "Ikhsan Fillah Hidayat",
              nim: "123230219",
              domisili: "Jakarta",
              kelas: "IF-E",
              hobi: "Main Mobile Legends",
              citaCita: "Jadi anak baik",
              minatTA: "Jaringan Komputer",
              pengalaman: "Admin Laboratorium",
              email: "ikhsanfillahhidayat@gmail.com",
              linkedIn: "Ikhsan Fillah Hidayat",
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 5),
            _buildExpandCard(
              image: 'assets/images/anggota1.jpg',
              nama: "Ikhsan Fillah Hidayat",
              nim: "123230219",
              domisili: "Jakarta",
              kelas: "IF-E",
              hobi: "Main Mobile Legends",
              citaCita: "Jadi anak baik",
              minatTA: "Jaringan Komputer",
              pengalaman: "Admin Laboratorium",
              email: "ikhsanfillahhidayat@gmail.com",
              linkedIn: "Ikhsan Fillah Hidayat",
              colorScheme: colorScheme,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildExpandCard({
  required String? image,
  required String nama,
  required String nim,
  required String domisili,
  required String kelas,
  required String hobi,
  required String citaCita,
  required String minatTA,
  required String pengalaman,
  required String email,
  required String linkedIn,
  required ColorScheme colorScheme,
}) {
  return Card(
    elevation: 0,
    color: colorScheme.surfaceContainerLow,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    clipBehavior: Clip.antiAlias,
    child: ExpansionTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: image != null ? AssetImage(image) : null,
        backgroundColor: colorScheme.primaryContainer,
        child: image == null
            ? Text(
                nama[0],
                style: TextStyle(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            : null,
      ),
      title: Text(nama, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(nim),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Divider(),
              _buildInfoRow("Kelas", kelas, colorScheme),
              _buildInfoRow("Domisili", domisili, colorScheme),
              _buildInfoRow("Hobi", hobi, colorScheme),
              _buildInfoRow("Cita-cita", citaCita, colorScheme),
              _buildInfoRow("Minat TA", minatTA, colorScheme),
              _buildInfoRow("Pengalaman", pengalaman, colorScheme),
              _buildInfoRow("Email", email, colorScheme),
              _buildInfoRow("LinkedIn", linkedIn, colorScheme),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoRow(String label, String value, ColorScheme colorScheme) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}
