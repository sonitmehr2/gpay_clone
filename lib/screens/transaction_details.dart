// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gpay_clone/resources/utils.dart';
import 'package:gpay_clone/services/firestore_methods.dart';
import 'package:gpay_clone/widgets/app_bar_transaction_details.dart';
import 'package:gpay_clone/widgets/transaction_details_card.dart';

import '../models/transaction_model.dart';
import '../resources/colors.dart';

class TransactionDetails extends StatefulWidget {
  final String sender_id;
  final String reciever_id;
  final String reciever_hex_color;
  final String reciever_name;
  const TransactionDetails({
    super.key,
    required this.sender_id,
    required this.reciever_id,
    required this.reciever_hex_color,
    required this.reciever_name,
  });

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  bool isLoading = true;
  double totalTransactionAmount = 0;
  int numberOfDays = 0;
  List<TransactionModel> transactionDetails = [];
  final ScrollController _scrollController = ScrollController();

  Future<void> _getTransactionDetails() async {
    List<String> transactions = await FireStoreMethods()
        .getTransactionDetailsHistory(widget.sender_id, widget.reciever_id);
    for (var element in transactions) {
      TransactionModel transactionDetail =
          await FireStoreMethods().getTransactionFromTransactionID(element);
      transactionDetails.add(transactionDetail);
      totalTransactionAmount += toDouble(transactionDetail.amount);
    }
    transactionDetails.sort((a, b) => a.time.compareTo(b.time));
    numberOfDays = getNumberOfDays(transactionDetails);
    setState(() {
      isLoading = false;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (_scrollController.hasClients) {
        _scrollDown();
      }
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
      appBar: AppBarTransactionDetails(
        duration: numberOfDays.toString(),
        total: totalTransactionAmount.toStringAsFixed(2),
        name: widget.reciever_name,
        hexColor: widget.reciever_hex_color,
      ),
      body: (isLoading)
          ? const Center(
              child: CircularProgressIndicator(
              color: primaryColor,
            ))
          : Column(
              children: [
                Expanded(
                    child: ListView.builder(
                        controller: _scrollController,
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

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  int getNumberOfDays(List<TransactionModel> transactionDetails) {
    if (transactionDetails.length > 2) {
      DateTime firstTime = stringToDateTime(transactionDetails.first.time);
      DateTime lastTime = stringToDateTime(transactionDetails.last.time);

      Duration difference = lastTime.difference(firstTime);
      return max(1, difference.inDays);
    }
    return 2;
  }
}
