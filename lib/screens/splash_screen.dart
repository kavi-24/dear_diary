import 'dart:async';

import 'package:dear_diary/screens/home.dart';
import 'package:dear_diary/widgets/liquid_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double loading = 0;

  @override
  void initState() {
    setTimer();
    super.initState();
  }

  // set a periodic timer to update the loading variable
  setTimer() async {
    Timer.periodic(const Duration(milliseconds: 25), (timer) {
      if (loading < 1.1) {
        setState(() {
          loading += 0.01;
        });
      } else {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: LiquidCircularProgressIndicator(
            value: loading,
            valueColor: const AlwaysStoppedAnimation(Colors.pink),
            backgroundColor: Colors.transparent,
            borderColor: Colors.transparent,
            borderWidth: 5.0,
            direction: Axis.vertical,
            center: Image.asset(
              "assets/images/loader_image.png",
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
