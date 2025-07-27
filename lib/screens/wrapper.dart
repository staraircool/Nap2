import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:napcoin_app/screens/authenticate/authenticate.dart';
import 'package:napcoin_app/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Home();
        } else {
          return const Authenticate();
        }
      },
    );
  }
}

