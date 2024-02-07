import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gpay_clone/screens/payment_succesful_screen.dart';
import 'package:gpay_clone/screens/tick_animation_screen.dart';

class PaymentSuccessWrapper extends StatefulWidget {
  final String amount;
  final String payingName;
  final String upiID;
  const PaymentSuccessWrapper({
    super.key,
    required this.amount,
    required this.payingName,
    required this.upiID,
  });

  @override
  State<PaymentSuccessWrapper> createState() => _PaymentSuccessWrapperState();
}

class _PaymentSuccessWrapperState extends State<PaymentSuccessWrapper> {
  bool isAnimation = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 2100), () {
      setState(() {
        isAnimation = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedContainer(
            margin: EdgeInsets.only(top: isAnimation ? 150 : 100),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: const TickAnimationScreen()),
        if (!isAnimation)
          Expanded(
            child: PaymentSuccessfulScreen(
                amount: widget.amount,
                payingName: widget.payingName,
                upiID: widget.upiID),
          ),
      ],
    )
        // : PaymentSuccessfulScreen(
        //     amount: widget.amount,
        //     payingName: widget.payingName,
        //     upiID: widget.upiID),
        );
  }
}
