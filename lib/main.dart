import 'package:flutter/material.dart';
import 'package:tugas_1/pages/login1_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matematika Bahagia',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 247, 255),
          brightness: Brightness.light,
        ),
      ),
      home: const Login1Page(),
    );
  }
}
