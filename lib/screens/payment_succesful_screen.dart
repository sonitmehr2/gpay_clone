import 'package:flutter/material.dart';
import 'package:gpay_clone/resources/utils.dart';
import 'package:gpay_clone/screens/home_screen.dart';
import 'package:lottie/lottie.dart';

import '../styles/payment_succes_screen_styles.dart';

class PaymentSuccessfulScreen extends StatelessWidget {
  final String amount;
  final String bankingName;
  final String upiID;
  const PaymentSuccessfulScreen({
    super.key,
    required this.amount,
    required this.bankingName,
    required this.upiID,
  });

  @override
  Widget build(BuildContext context) {
    String dateTime = getCurrentDate();
    int transactionID = generateRandom8DigitNumber();
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          Center(
            // child: Container(
            //   color: Colors.red,
            //   width: 300,
            //   height: 200,
            // ),
            child: Container(
              // color: Colors.red,
              child: Lottie.asset(
                  'assets/animation/tick.json', // Replace with your animation file path
                  width: 300,
                  height: 280,
                  fit: BoxFit.fitHeight,
                  repeat: false),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              "₹${toDoubleString(amount)}",
              style: amountStyle,
            ),
          ),
          Text(
            "Paid to ${bankingName.substring(7)}",
            style: paidToStyle,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              upiID,
              style: upiIDStyle,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Text(
            dateTime,
            style: dateTimeStyle,
          ),
          Text(
            "UPI transaction ID: 372400$transactionID",
            style: upiTransactionStyle,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          constraints: buttonBoxConstraints,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.5,
                                  color: shareScreenShotBorderColor),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Icon(
                                  Icons.share,
                                  color: shareColor,
                                ),
                              ),
                              Text(
                                'Share Screenshot',
                                style: shareScreenShotStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()),
                                (route) => false);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            constraints: buttonBoxConstraints,
                            decoration: BoxDecoration(
                                color: shareColor,
                                border: Border.all(
                                    width: 1,
                                    color: shareScreenShotBorderColor),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              'Done',
                              style: doneStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}