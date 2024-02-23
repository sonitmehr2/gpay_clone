// ignore_for_file: use_build_context_synchronously

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gpay_clone/resources/utils.dart';
import 'package:gpay_clone/screens/home_screen_drawer.dart';
import 'package:gpay_clone/screens/payment_successful_screen_wrapper.dart';
import 'package:gpay_clone/screens/recent_people.dart';
import 'package:gpay_clone/screens/scanner_screen.dart';
import 'package:gpay_clone/screens/transaction_history.dart';
import 'package:gpay_clone/styles/home_screen_styles.dart';
import 'package:gpay_clone/widgets/arrow_list_tile.dart';
import 'package:gpay_clone/widgets/asset_image.dart';
import 'package:gpay_clone/widgets/search_bar.dart';
import 'package:gpay_clone/widgets/user_profile_icon.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart' as model;
import '../providers/user_providers.dart';
import '../resources/colors.dart';
import '../resources/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    Color iconbackgroundColor = hexToColor(user.hexColor);
    // final UserProvider userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const HomeScreenDrawer(),
        backgroundColor: backgroundColor,
        body: (user.uid == "")
            ? const Center(
                child: CircularProgressIndicator(color: primaryColor),
              )
            : SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16.0),
                    child: Row(
                      children: [
                        const SizedBox(
                            width: 280, height: 48, child: CustomSearchBar()),
                        GestureDetector(
                          onTap: () => _scaffoldKey.currentState?.openDrawer(),
                          child: UserProfileIcon(
                            backgroundColor: iconbackgroundColor,
                            radius: 17,
                            name: user.name,
                          ),
                        )
                      ],
                    ),
                  ),
                  AssetImageViewer(assetImage: homeScreenImage, height: 160),
                  const SizedBox(
                    height: 10,
                  ),
                  iconsFirstRow(context),
                  iconsSecondRow(context),
                  Center(
                    child: Container(
                        width: 165,
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 14),
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: upiIDBorderColor),
                            borderRadius: BorderRadius.circular(16)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('UPI ID: vpa@bank'),
                            Icon(
                              Icons.copy_sharp,
                              size: 20,
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16.0),
                      child: Text(
                        'People',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: const RecentPeople()),
                  ArrowListTile(
                    icon: const Icon(
                      Icons.history,
                      color: gpayBlue,
                    ),
                    text: "Show transaction history",
                    builder: (context) => const TransactionHistory(),
                  ),
                  AssetImageViewer(assetImage: inviteFriendsImage, height: 300),
                  const Padding(
                    padding: EdgeInsets.all(34.0),
                    child: Text(
                      'Showing businesses based on your location - Learn more',
                      textAlign: TextAlign.center,
                      style: bottomTextStyle,
                    ),
                  )
                ]),
              ),
      ),
    );
  }
}

Widget iconsFirstRow(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: iconWidth,
            height: iconHeight,
            child: callToActionIcon(context, "assets/images/scan_icon.PNG",
                "Scan any QR Code", (context) => ScanPage())),
        SizedBox(
            width: iconWidth,
            height: iconHeight,
            child: callToActionIcon(
                context,
                "assets/images/pay_contacts.PNG",
                "Pay contacts",
                (context) => PaymentSuccessWrapper(
                    amount: "20",
                    payingName: "BANKING NAME : Enzo Shop",
                    upiID: "Enzo@paytm"))),
        SizedBox(
            width: iconWidth,
            height: iconHeight,
            child: callToActionIcon(context, "assets/images/pay_to_phone.PNG",
                "Pay to Phone ", (context) => const SizedBox.shrink())),
        SizedBox(
            width: iconWidth,
            height: iconHeight,
            child: callToActionIcon(context, "assets/images/bank_transfer.PNG",
                "Bank Transfer", (context) => const SizedBox.shrink())),
      ],
    ),
  );
}

Widget iconsSecondRow(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: iconWidth,
            height: iconHeight,
            child: callToActionIcon(context, "assets/images/pay_to_upi_id.PNG",
                "Pay to UPI ID", (context) => const SizedBox.shrink())),
        SizedBox(
            width: iconWidth,
            height: iconHeight,
            child: callToActionIcon(context, "assets/images/self_transder.PNG",
                "Self transfer", (context) => const SizedBox.shrink())),
        SizedBox(
            width: iconWidth,
            height: iconHeight,
            child: callToActionIcon(context, "assets/images/pay_bills.PNG",
                "Pay bills", (context) => const SizedBox.shrink())),
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
  );
}

Widget callToActionIcon(BuildContext context, String imageAsset, String text,
    Widget Function(BuildContext) builder) {
  return GestureDetector(
    onTap: () async {
      final AudioPlayer audioPlayer = AudioPlayer();

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
