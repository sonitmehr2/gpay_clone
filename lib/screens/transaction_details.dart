// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gpay_clone/services/firestore_methods.dart';
import 'package:gpay_clone/widgets/transaction_details_card.dart';

import '../models/transaction_model.dart';
import '../resources/colors.dart';

class TransactionDetails extends StatefulWidget {
  final String sender_id;
  final String reciever_id;
  const TransactionDetails({
    super.key,
    required this.sender_id,
    required this.reciever_id,
  });

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  bool isLoading = true;
  List<TransactionModel> transactionDetails = [];

  Future<void> _getTransactionDetails() async {
    List<String> transactions = await FireStoreMethods()
        .getTransactionDetailsHistory(widget.sender_id, widget.reciever_id);
    for (var element in transactions) {
      TransactionModel transactionDetail =
          await FireStoreMethods().getTransactionFromTransactionID(element);
      transactionDetails.add(transactionDetail);
    }
    transactionDetails.sort((a, b) => a.time.compareTo(b.time));
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTransactionDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction Details')),
      body: (isLoading)
          ? const Center(
              child: CircularProgressIndicator(
              color: primaryColor,
            ))
          : Column(
              children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: transactionDetails.length,
                        itemBuilder: (context, index) {
                          TransactionModel transactionDetail =
                              transactionDetails[index];
                          return TransactionDetailsCard(
                              amount: transactionDetail.amount,
                              time: transactionDetail.time);
                        })),
              ],
            ),
    );
  }
}
