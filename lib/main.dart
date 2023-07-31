import 'package:flutter/material.dart';
import 'package:flutter_cityperu_ui/ui/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Perú',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
