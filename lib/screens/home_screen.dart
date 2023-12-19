import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpay_clone/screens/payment_screen.dart';
import 'package:gpay_clone/styles/home_screen_styles.dart';
import 'package:gpay_clone/widgets/search_bar.dart';
import 'package:gpay_clone/widgets/user_profile_icon.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart' as model;
import '../providers/user_providers.dart';
import '../resources/constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    // final UserProvider userProvider = Provider.of<UserProvider>(context);
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: iconWidth,
                      height: iconHeight,
                      child: callToActionIcon(
                          context,
                          "assets/images/scan_icon.PNG",
                          "Scan any QR Code",
                          (context) => PaymentScreen())),
                  SizedBox(
                      width: iconWidth,
                      height: iconHeight,
                      child: callToActionIcon(
                          context,
                          "assets/images/pay_contacts.PNG",
                          "Pay contacts",
                          (context) => const SizedBox.shrink())),
                  SizedBox(
                      width: iconWidth,
                      height: iconHeight,
                      child: callToActionIcon(
                          context,
                          "assets/images/pay_to_phone.PNG",
                          "Pay to Phone ",
                          (context) => const SizedBox.shrink())),
                  SizedBox(
                      width: iconWidth,
                      height: iconHeight,
                      child: callToActionIcon(
                          context,
                          "assets/images/bank_transfer.PNG",
                          "Bank Transfer",
                          (context) => const SizedBox.shrink())),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: iconWidth,
                      height: iconHeight,
                      child: callToActionIcon(
                          context,
                          "assets/images/pay-to-upi.PNG",
                          "Pay to UPI ID",
                          (context) => PaymentScreen())),
                  SizedBox(
                      width: iconWidth,
                      height: iconHeight,
                      child: callToActionIcon(
                          context,
                          "assets/images/self_transder.PNG",
                          "Self transfer",
                          (context) => const SizedBox.shrink())),
                  SizedBox(
                      width: iconWidth,
                      height: iconHeight,
                      child: callToActionIcon(
                          context,
                          "assets/images/pay_bills.PNG",
                          "Pay bills",
                          (context) => const SizedBox.shrink())),
                  SizedBox(
                      width: iconWidth,
                      height: iconHeight,
                      child: callToActionIcon(
                          context,
                          "assets/images/mobile_recharge.PNG",
                          "Mobile Recharge",
                          (context) => const SizedBox.shrink())),
                ],
              ),
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

Widget callToActionIcon(BuildContext context, String imageAsset, String text,
    Widget Function(BuildContext) builder) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: builder));
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          imageAsset,
        ),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        )
      ],
    ),
  );
}
