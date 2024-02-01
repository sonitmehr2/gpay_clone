// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gpay_clone/models/user_model.dart' as model;
import 'package:gpay_clone/screens/payment_succesful_screen.dart';
import 'package:gpay_clone/services/firestore_methods.dart';
import 'package:gpay_clone/widgets/user_profile_icon.dart';
import 'package:provider/provider.dart';

import '../providers/user_providers.dart';
import '../resources/utils.dart';

class PaymentScreen extends StatefulWidget {
  final String scanID;
  const PaymentScreen({super.key, required this.scanID});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController _nameController = TextEditingController();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final TextEditingController _upiIDController = TextEditingController();

  final TextEditingController _bankingNameController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();
  double multiply = 0.1;

  Future<void> _addTransaction(
      String sender_id, String reciever_id, String senderHexColor) async {
    bool check = await FireStoreMethods().addTransactionDetails(
        sender_id,
        reciever_id,
        _amountController.text,
        _nameController.text,
        senderHexColor);
    if (check) {
      UserProvider _userProvider = Provider.of(context, listen: false);
      _userProvider.refreshUser();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentSuccessfulScreen(
                    amount: _amountController.text,
                    bankingName: _nameController.text,
                    upiID: _upiIDController.text,
                  )));
    } else {
      showSnackBar(context, "UPI ID Not Found");
    }
  }

  Future<void> getRecieverDetails() async {
    String upiID = "";

    DocumentReference scanLinkDoc =
        _firebaseFirestore.collection("scan_id_link").doc(widget.scanID);
    DocumentSnapshot scanLinkSnap = await scanLinkDoc.get();
    upiID = scanLinkSnap['upiID'];

    DocumentReference userDoc =
        _firebaseFirestore.collection("users").doc(upiID);
    DocumentSnapshot userDocSnap = await userDoc.get();

    // setState(() {
    _upiIDController.text = "hello";
    _nameController.text = userDocSnap['name'];
    _bankingNameController.text = userDocSnap['name'];
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecieverDetails();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    double fullScreenWidth = MediaQuery.of(context).size.width;
    double fullScreenHeight = MediaQuery.of(context).size.height;
    double heightOfTextField = 25;
    double amountFieldSize = 55;
    double variableMaxwidth = fullScreenWidth * multiply;
    Color backgroundColor = hexToColor(user.hexColor);

    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () async => await _addTransaction(
            user.uid, _upiIDController.text, user.hexColor),
        child: const Icon(Icons.arrow_right_alt_outlined),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserProfileIcon(
              backgroundColor: backgroundColor,
              radius: 20,
              name: user.name,
            ),
            SizedBox(
              width: fullScreenWidth * 0.8,
              height: heightOfTextField,
              child: TextField(
                focusNode: FocusNode(),
                decoration: const InputDecoration(border: InputBorder.none),
                textAlign: TextAlign.center,
                controller: _nameController,
              ),
            ),
            SizedBox(
              height: heightOfTextField,
              width: fullScreenWidth * 0.8,
              child: TextField(
                decoration: const InputDecoration(border: InputBorder.none),
                textAlign: TextAlign.center,
                controller: _upiIDController,
              ),
            ),
            SizedBox(
              height: heightOfTextField,
              width: fullScreenWidth * 0.8,
              child: TextField(
                decoration: const InputDecoration(border: InputBorder.none),
                textAlign: TextAlign.center,
                controller: _bankingNameController,
              ),
            ),
            SizedBox(
              height: fullScreenHeight * 0.1,
              child: Container(
                  constraints: BoxConstraints(
                    maxWidth: variableMaxwidth,
                    minWidth: fullScreenWidth * 0.1,
                  ),
                  // height: fullScreenHeight * 0.1,
                  // width: fullScreenWidth * 0.9,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.phone,
                    cursorHeight: amountFieldSize,
                    style: TextStyle(fontSize: amountFieldSize),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          multiply = 0.1;
                        });
                        return;
                      }
                      setState(() {
                        multiply = 0.1 * value.length;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "0",
                        contentPadding: const EdgeInsets.only(left: 0),
                        hintStyle: TextStyle(fontSize: amountFieldSize),
                        border: InputBorder.none),
                    controller: _amountController,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
