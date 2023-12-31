import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF560E09,
          <int, Color>{
            50: Color(0xFF560E09),
            100: Color(0xFF560E09),
            200: Color(0xFF560E09),
            300: Color(0xFF560E09),
            400: Color(0xFF560E09),
            500: Color(0xFF560E09),
            600: Color(0xFF560E09),
            700: Color(0xFF560E09),
            800: Color(0xFF560E09),
            900: Color(0xFF560E09),
          },
        ),
      ),
      home: const HomePage(),
    );
  }
}
