import 'package:flutter/material.dart';

import '../resources/colors.dart';

class BottomSheetPaymentLoading extends StatelessWidget {
  final String name;
  final String amount;
  const BottomSheetPaymentLoading(
      {super.key, required this.name, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // shadow color
            spreadRadius: 5, // spread radius
            blurRadius: 7, // blur radius
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(children: [
        SizedBox(
            width: 60,
            height: 60,
            child: Transform.scale(
                scale: 0.35,
                child: const CircularProgressIndicator(
                  strokeWidth: 8,
                  color: blueButtonColor,
                ))),
        Text(
          'Paying $name ₹$amount',
          style: const TextStyle(fontFamily: 'Product Sans', fontSize: 18),
        ),
      ]),
    );
  }
}
