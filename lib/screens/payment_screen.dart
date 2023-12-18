import 'package:flutter/material.dart';
import 'package:gpay_clone/resources/constants.dart';
import 'package:gpay_clone/widgets/user_profile_icon.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});
  final TextEditingController _nameController =
      TextEditingController(text: 'Paying SONIT MEHROTRA');
  final TextEditingController _upiIDController =
      TextEditingController(text: 'sonitmyl@okaxis');
  final TextEditingController _bankingNameController =
      TextEditingController(text: 'Banking name: SONIT MEHROTRA');
  final TextEditingController _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double fullScreenWidth = MediaQuery.of(context).size.width;
    double fullScreenHeight = MediaQuery.of(context).size.height;
    double heightOfTextField = 25;
    double amountFieldSize = 44;
    return Scaffold(
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
            Center(
              child: Container(
                  constraints: BoxConstraints(
                    maxWidth: fullScreenWidth * 0.8,
                    minWidth: fullScreenWidth * 0.1,
                    maxHeight: fullScreenHeight * 0.1,
                  ),
                  // height: fullScreenHeight * 0.1,
                  // width: fullScreenWidth * 0.9,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.phone,
                    cursorHeight: amountFieldSize,
                    style: TextStyle(fontSize: amountFieldSize),
                    decoration: InputDecoration(
                        hintText: "0",
                        contentPadding: EdgeInsets.only(left: 0),
                        // prefixIcon: Container(color: Colors.red),
                        // prefixIcon: Text(
                        //   '₹',
                        //   style: TextStyle(
                        //       color: Colors.black, fontSize: amountFieldSize),
                        // ),
                        hintStyle: TextStyle(fontSize: amountFieldSize),
                        border: OutlineInputBorder()),
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
