// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gpay_clone/models/user_model.dart' as model;
import 'package:gpay_clone/screens/payment_successful_screen_wrapper.dart';
import 'package:gpay_clone/services/firestore_methods.dart';
import 'package:provider/provider.dart';

import '../providers/user_providers.dart';
import '../resources/colors.dart';
import '../resources/utils.dart';

class PaymentScreen extends StatefulWidget {
  final String upiID;
  const PaymentScreen({super.key, required this.upiID});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _payingNameController =
      TextEditingController(text: "S");
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final TextEditingController _upiIDController = TextEditingController();

  final TextEditingController _bankingNameController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();
  Color receiverColor = Colors.green;
  double multiply = 0.1;

  Future<void> _addTransaction(
      String sender_id, String reciever_id, String senderHexColor) async {
    bool check = await FireStoreMethods().addTransactionDetails(
        sender_id,
        reciever_id,
        _amountController.text,
        _bankingNameController.text,
        senderHexColor);
    if (check) {
      UserProvider _userProvider = Provider.of(context, listen: false);
      _userProvider.refreshUser();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentSuccessWrapper(
                    amount: _amountController.text,
                    payingName: _payingNameController.text,
                    upiID: _upiIDController.text,
                  )));
    } else {
      showSnackBar(context, "UPI ID Not Found");
    }
  }

  Future<void> getRecieverDetails() async {
    DocumentReference userDoc =
        _firebaseFirestore.collection("users").doc(widget.upiID);
    DocumentSnapshot userDocSnap = await userDoc.get();

    // setState(() {
    _upiIDController.text = widget.upiID;
    _payingNameController.text = "Paying ${userDocSnap['paying_name']}";
    _bankingNameController.text = "Banking Name : ${userDocSnap['name']}";
    receiverColor = hexToColor(userDocSnap['hexColor']);
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
    double heightOfTextField = 23;
    double amountFieldSize = 55;
    double variableMaxwidth = fullScreenWidth * multiply;
    Color backgroundColor = hexToColor(user.hexColor);

    return Scaffold(
      floatingActionButton: SizedBox(
        height: 50,
        width: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: blueButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Button border radius
            ),
          ),
          onPressed: () async => await _addTransaction(
              user.uid, _upiIDController.text, user.hexColor),
          child: const Icon(Icons.arrow_forward),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SizedBox(
                width: 60,
                child: CircleAvatar(
                  radius: 27,
                  backgroundColor: backgroundColor,
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _payingNameController.text
                            .substring(0, 1)
                            .toUpperCase(),
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
                      )),
                ),
              ),
            ),
            SizedBox(
              width: fullScreenWidth * 0.8,
              height: heightOfTextField,
              child: TextField(
                focusNode: FocusNode(),
                decoration: const InputDecoration(border: InputBorder.none),
                textAlign: TextAlign.center,
                controller: _payingNameController,
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
                    autofocus: true,
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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              decoration: BoxDecoration(
                  color: greyAddNote, borderRadius: BorderRadius.circular(10)),
              child: const Text('Add a note'),
            )
          ],
        ),
      ),
    );
  }
}
