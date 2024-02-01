import 'package:flutter/material.dart';

class TransactionDetailsCard extends StatelessWidget {
  final String amount;
  final String time;

  const TransactionDetailsCard({
    super.key,
    required this.amount,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(amount),
      subtitle: Text(time),
    );
  }
}
