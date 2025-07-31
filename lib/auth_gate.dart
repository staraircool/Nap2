import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:napcoin_app/screens/login_screen.dart';
import 'package:napcoin_app/screens/home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = Supabase.instance.client.auth.currentSession;

        if (session != null) {
          return const HomeScreen(); // If user is logged in
        } else {
          return const LoginScreen(); // If user is not logged in
        }
      },
    );
  }
}
