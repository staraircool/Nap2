import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register with email and password
  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String username, String fullName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'full_name': fullName,
          'username': username,
          'mining_rate': 4.3333, // Base mining rate
          'mining_started_at': null,
          'nap_mined_total': 0.0,
          'is_mining': false,
          'referral_code': user.uid.substring(0, 6), // Simple referral code
          'referred_by': null,
          'referrals_count': 0,
        });
      }
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Stream of user changes
  Stream<User?> get user {
    return _auth.authStateChanges();
  }
}


