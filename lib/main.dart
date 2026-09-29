import 'package:flutter/material.dart';
import 'core/api.dart';
import 'screens/home.dart';

void main() => runApp(const FurlessCustomerApp());

class FurlessCustomerApp extends StatelessWidget {
  const FurlessCustomerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF14B8AE),
      brightness: Brightness.light,
    ).copyWith(
      primary: const Color(0xFF0A3147),
      secondary: const Color(0xFF14B8AE),
      tertiary: const Color(0xFF4B7DFF),
      surface: Colors.white,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Furless',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: const Color(0xFFF3FAFB),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Color(0xFF0A3147),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(color: Color(0xFFD9E8EB)),
          ),
        ),
      ),
      home: HomeScreen(api: Api()),
    );
  }
}
