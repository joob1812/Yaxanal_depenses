import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // AJOUTEZ CET IMPORT
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // AJOUTEZ CETTE LIGNE
  await initializeDateFormatting('fr_FR'); // AJOUTEZ CETTE LIGNE
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yaxanal Dépenses',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(
          0xFFF5F5F5,
        ), // REMPLACEZ AppConstants.backgroundColor
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(
            0xFF4CAF50,
          ), // REMPLACEZ AppConstants.primaryColor
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(
            0xFF4CAF50,
          ), // REMPLACEZ AppConstants.primaryColor
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
