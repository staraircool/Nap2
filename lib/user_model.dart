import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String fullName;
  final String username;
  double miningRate;
  Timestamp? miningStartedAt;
  double napMinedTotal;
  bool isMining;
  final String referralCode;
  String? referredBy;
  int referralsCount;

  UserModel({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.username,
    this.miningRate = 4.3333,
    this.miningStartedAt,
    this.napMinedTotal = 0.0,
    this.isMining = false,
    required this.referralCode,
    this.referredBy,
    this.referralsCount = 0,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      email: data["email"] ?? "",
      fullName: data["full_name"] ?? "",


      username: data["username"] ?? "",
      miningRate: (data["mining_rate"] ?? 4.3333).toDouble(),
      miningStartedAt: data["mining_started_at"] as Timestamp?,
      napMinedTotal: (data["nap_mined_total"] ?? 0.0).toDouble(),
      isMining: data["is_mining"] ?? false,
      referralCode: data["referral_code"] ?? "",
      referredBy: data["referred_by"],
      referralsCount: (data["referrals_count"] ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "email": email,
      "full_name": fullName,
      "username": username,
      "mining_rate": miningRate,
      "mining_started_at": miningStartedAt,
      "nap_mined_total": napMinedTotal,
      "is_mining": isMining,
      "referral_code": referralCode,
      "referred_by": referredBy,
      "referrals_count": referralsCount,
    };
  }
}


