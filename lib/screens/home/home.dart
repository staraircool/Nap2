import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:napcoin_app/auth_service.dart';
import 'package:napcoin_app/database_service.dart';
import 'package:napcoin_app/mining_service.dart';
import 'package:napcoin_app/user_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final AuthService _auth = AuthService();
  final DatabaseService _dbService = DatabaseService();
  final MiningService _miningService = MiningService();

  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    _pulseController.repeat(reverse: true);
    _rotationController.repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.getCurrentUser();
    
    return StreamBuilder<UserModel>(
      stream: _dbService.getUser(user!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserModel userData = snapshot.data!;
          
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text('NAPCOIN MINER', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                ),
              ],
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Column(
                children: <Widget>[
                  // User info section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Welcome, ${userData.username}! 👋',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Total NAP Mined: ${userData.napMinedTotal.toStringAsFixed(4)} 💰',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Mining Rate: ${userData.miningRate.toStringAsFixed(4)} NAP/hr ⚡',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Referrals: ${userData.referralsCount} 👥',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Mining status and button
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (userData.isMining) ...[
                          AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _pulseAnimation.value,
                                child: const Text(
                                  '😴 NAPPING IN PROGRESS... 😴',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          AnimatedBuilder(
                            animation: _rotationAnimation,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: _rotationAnimation.value * 2 * 3.14159,
                                child: const Icon(
                                  Icons.bedtime,
                                  size: 100,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Dreams are being converted to NAP... 💭➡️💰',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            ),
                            onPressed: () {
                              _miningService.stopMining(userData);
                            },
                            child: const Text(
                              'WAKE UP 😵',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ] else ...[
                          const Text(
                            '🌙 READY TO NAP? 🌙',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Icon(
                            Icons.hotel,
                            size: 100,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Time to turn your ZZZs into NAPs! 💤➡️💰',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            ),
                            onPressed: () {
                              _miningService.startMining(userData);
                            },
                            child: const Text(
                              'START NAPPING 😴',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  // Referral section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Your Referral Code:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Text(
                            userData.referralCode,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Share this code to earn +1.333 NAP/hr per referral! 🚀',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }
      },
    );
  }
}

