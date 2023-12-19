import 'package:flutter/material.dart';
import 'package:gpay_clone/models/user_model.dart';
import 'package:gpay_clone/resources/constants.dart';
import 'package:gpay_clone/services/firestore_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final FireStoreMethods _fireStoreMethods = FireStoreMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _fireStoreMethods.getUserDetails(senderUpi);
    _user = user;
    notifyListeners();
  }
}
