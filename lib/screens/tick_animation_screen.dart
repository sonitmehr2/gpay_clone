import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TickAnimationScreen extends StatelessWidget {
  const TickAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // color: Colors.red,
        child: Lottie.asset(
            'assets/animation/tick.json', // Replace with your animation file path
            width: 300,
            height: 280,
            fit: BoxFit.fitHeight,
            repeat: false),
      ),
    );
  }
}
