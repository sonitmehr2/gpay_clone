import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gpay_clone/screens/payment_screen.dart';
import 'package:gpay_clone/styles/home_screen_styles.dart';
import 'package:gpay_clone/widgets/search_bar.dart';
import 'package:gpay_clone/widgets/user_profile_icon.dart';

import '../resources/constants.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16.0),
              child: Row(
                children: [
                  const Expanded(child: CustomSearchBar()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UserProfileIcon(
                      imageAsset: girlImage,
                      radius: 20,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 160,
              child: Image.asset(
                homeScreenImage,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: iconWidth,
                    height: iconHeight,
                    child: callToActionIcon(context, girlImage, "Hello")),
                SizedBox(
                    width: iconWidth,
                    height: iconHeight,
                    child: callToActionIcon(context, girlImage, "Hello")),
                SizedBox(
                    width: iconWidth,
                    height: iconHeight,
                    child: callToActionIcon(context, girlImage, "Hello")),
                SizedBox(
                    width: iconWidth,
                    height: iconHeight,
                    child: callToActionIcon(context, girlImage, "Hello")),
              ],
            ),
            Center(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: upiIDBorderColor),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text('UPI ID: vpa@bank')),
            )
          ]),
        ),
      ),
    );
  }

  Future<void> checkFirebase() async {
    firebaseFirestore.collection("hello").doc("hi").set({"test": "hello"});
  }
}

Widget callToActionIcon(BuildContext context, String imageAsset, String text) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PaymentScreen()));
    },
    child: Column(
      children: [
        Image.asset(
          imageAsset,
        ),
        Text(text)
      ],
    ),
  );
}
