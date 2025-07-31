import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:napcoin_app/screens/login_screen.dart'; // Supabase Login screen
import 'package:napcoin_app/screens/home_screen.dart';  // Show after login

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://YOUR-PROJECT.supabase.co',       // 🔁 Replace with your Supabase URL
    anonKey: 'YOUR-ANON-KEY',                      // 🔁 Replace with your public anon key
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NAPCOIN',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[800],
          labelStyle: const TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const AuthGate(),
    );
  }
}
