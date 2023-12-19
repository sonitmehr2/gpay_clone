import 'package:flutter/material.dart';
import 'package:gpay_clone/models/user_model.dart' as model;
import 'package:gpay_clone/resources/constants.dart';
import 'package:gpay_clone/services/firestore_methods.dart';
import 'package:gpay_clone/widgets/user_profile_icon.dart';
import 'package:provider/provider.dart';

import '../providers/user_providers.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Paying SONIT MEHROTRA');

  final TextEditingController _upiIDController =
      TextEditingController(text: recieverUpi);

  final TextEditingController _bankingNameController =
      TextEditingController(text: 'Banking name: SONIT MEHROTRA');

  final TextEditingController _amountController = TextEditingController();
  double multiply = 0.1;

  _addTransaction(String sender_id, String reciever_id) async {
    await FireStoreMethods()
        .addTransactionDetails(sender_id, reciever_id, _amountController.text);
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    double fullScreenWidth = MediaQuery.of(context).size.width;
    double fullScreenHeight = MediaQuery.of(context).size.height;
    double heightOfTextField = 25;
    double amountFieldSize = 55;
    double variableMaxwidth = fullScreenWidth * multiply;

    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () async => await _addTransaction(user.uid, recieverUpi),
        child: const Icon(Icons.arrow_right_alt_outlined),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserProfileIcon(imageAsset: girlImage, radius: 30),
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
                      if (value.length == 0) {
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
                        contentPadding: EdgeInsets.only(left: 0),
                        hintStyle: TextStyle(fontSize: amountFieldSize),
                        border: InputBorder.none),
                    // decoration: const InputDecoration(
                    //   border: OutlineInputBorder(),
                    //   contentPadding: EdgeInsets.all(16),
                    //   hintText: "0",
                    // ),
                    controller: _amountController,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
