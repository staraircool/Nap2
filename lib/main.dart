import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:napcoin_app/auth_service.dart';
import 'package:napcoin_app/screens/wrapper.dart';
import 'package:napcoin_app/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
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
        home: const Wrapper(),
      ),
    );
  }
}


