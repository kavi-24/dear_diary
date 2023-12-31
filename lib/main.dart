
import 'package:dear_diary/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main(List<String> args) { 
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}