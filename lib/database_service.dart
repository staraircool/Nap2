import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:napcoin_app/user_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get user data by UID
  Stream<UserModel> getUser(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map(
        (snapshot) => UserModel.fromDocument(snapshot));
  }

  // Update user data
  Future<void> updateUserData(UserModel user) async {
    return await _firestore.collection('users').doc(user.uid).set(user.toMap());
  }

  // Get user by referral code
  Future<UserModel?> getUserByReferralCode(String referralCode) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('referral_code', isEqualTo: referralCode)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return UserModel.fromDocument(snapshot.docs.first);
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}


