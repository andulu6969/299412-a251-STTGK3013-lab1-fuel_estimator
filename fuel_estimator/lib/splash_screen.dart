import 'package:flutter/material.dart';
import 'package:fuel_estimator/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/fuel_estimator.png', scale: 3),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.black),
            const SizedBox(height: 20),
            const Text("Loading...", style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
