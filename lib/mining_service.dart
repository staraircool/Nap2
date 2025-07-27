import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:napcoin_app/user_model.dart';
import 'package:napcoin_app/database_service.dart';

class MiningService {
  final DatabaseService _dbService = DatabaseService();
  Timer? _miningTimer;
  static const double BASE_MINING_RATE = 4.3333; // NAP/hour
  static const double REFERRAL_BONUS_RATE = 1.333; // NAP/hour per referral
  static const int MINING_SESSION_DURATION_HOURS = 12;

  void startMining(UserModel user) async {
    if (!user.isMining) {
      user.isMining = true;
      user.miningStartedAt = Timestamp.now();
      await _dbService.updateUserData(user);

      _miningTimer = Timer.periodic(Duration(minutes: 1), (timer) async {
        // Calculate elapsed time in hours
        double elapsedHours = (Timestamp.now().millisecondsSinceEpoch - user.miningStartedAt!.millisecondsSinceEpoch) / (1000 * 60 * 60);

        if (elapsedHours >= MINING_SESSION_DURATION_HOURS) {
          stopMining(user);
          return;
        }

        // Calculate current mining rate based on referrals
        double currentMiningRate = BASE_MINING_RATE + (user.referralsCount * REFERRAL_BONUS_RATE);

        // Calculate NAP mined in this minute
        double napMinedThisMinute = currentMiningRate / 60;

        user.napMinedTotal += napMinedThisMinute;
        await _dbService.updateUserData(user);
      });
    }
  }

  void stopMining(UserModel user) async {
    if (user.isMining) {
      _miningTimer?.cancel();
      user.isMining = false;
      user.miningStartedAt = null;
      await _dbService.updateUserData(user);
    }
  }

  Future<void> applyReferral(UserModel referrer, UserModel referredUser) async {
    // Check if the referred user has already been referred by someone
    if (referredUser.referredBy == null) {
      referredUser.referredBy = referrer.referralCode;
      referrer.referralsCount += 1;
      referrer.miningRate = BASE_MINING_RATE + (referrer.referralsCount * REFERRAL_BONUS_RATE);

      await _dbService.updateUserData(referrer);
      await _dbService.updateUserData(referredUser);
    }
  }
}


