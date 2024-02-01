// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gpay_clone/models/transaction_model.dart';
import 'package:gpay_clone/models/user_model.dart' as model;

class FireStoreMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<model.User> getUserDetails(String uid) async {
    DocumentSnapshot firebaseIDSnapShot = await _firebaseFirestore
        .collection("firebase_link_user")
        .doc(uid)
        .get();
    String upiID = firebaseIDSnapShot['upiID'];
    DocumentReference userDoc =
        _firebaseFirestore.collection("users").doc(upiID);
    DocumentSnapshot userDocSnap = await userDoc.get();
    QuerySnapshot recentPeopleSnap =
        await userDoc.collection("recent_people_list").get();
    return await model.User.fromSnapshot(userDocSnap, recentPeopleSnap);
  }

  Future<bool> addTransactionDetails(String sender_id, String reciever_id,
      String amount, String bankingName, String hexColor) async {
    String time = DateTime.now().toString();
    String name = bankingName.substring(7);
    DocumentReference recieverCollection =
        _firebaseFirestore.collection("users").doc(reciever_id);

    DocumentSnapshot receiverCollectionSnapshot =
        await recieverCollection.get();

    if (!receiverCollectionSnapshot.exists || sender_id == reciever_id) {
      return false;
    }
    String receiverProfileColor = receiverCollectionSnapshot['hexColor'];
    String recieverName = receiverCollectionSnapshot['name'];
    TransactionModel transactionModel = TransactionModel(
        amount: amount,
        sender_id: sender_id,
        reciever_id: reciever_id,
        time: time,
        name: name);
    Map<String, dynamic> transactionMap = transactionModel.toJson();

    DocumentReference transaction =
        await _firebaseFirestore.collection('transactions').add(transactionMap);

    String transaction_id = transaction.id;

    DocumentReference senderCollection =
        _firebaseFirestore.collection("users").doc(sender_id);

    DocumentReference senderRecentPeopleCollection =
        senderCollection.collection("recent_people_list").doc(reciever_id);
    DocumentSnapshot senderRecentPeopleSnapshot =
        await senderRecentPeopleCollection.get();

    Map<String, dynamic> updateQuery = {
      "last_transaction_time": DateTime.now().toString()
    };
    if (senderRecentPeopleSnapshot.exists) {
      senderRecentPeopleCollection.update(updateQuery);
    } else {
      senderRecentPeopleCollection.set(updateQuery);
    }
    transactionMap['hexColor'] = receiverProfileColor;
    transactionMap['name'] = recieverName;
    await senderCollection
        .collection("transaction_history")
        .doc(transaction_id)
        .set(transactionMap);
    transactionMap['hexColor'] = hexColor;
    transactionMap['name'] = bankingName;

    await recieverCollection
        .collection("transaction_history")
        .doc(transaction_id)
        .set(transactionMap);
    // await senderCollection.set({
    //   'transaction_history': FieldValue.arrayUnion([transaction_id])
    // }, SetOptions(merge: true));

    // await recieverCollection.set({
    //   'transaction_history': FieldValue.arrayUnion([transaction_id])
    // }, SetOptions(merge: true));
    return true;
  }

  Future<List<String>> getTransactionDetailsHistory(
      String sender_id, String reciever_id) async {
    CollectionReference senderUserDetails = _firebaseFirestore
        .collection("users")
        .doc(sender_id)
        .collection("transaction_history");
    CollectionReference reciverUserDetails = _firebaseFirestore
        .collection("users")
        .doc(reciever_id)
        .collection("transaction_history");
    QuerySnapshot senderTransactionDetails = await senderUserDetails.get();
    QuerySnapshot reciverTransactionDetails = await reciverUserDetails.get();

    Map<String, int> uniqueTransactions = {};

    senderTransactionDetails.docs.forEach((element) {
      if (element.id != "ignore_this_collection") {
        if (uniqueTransactions.containsKey(element.id)) {
          uniqueTransactions[element.id] = uniqueTransactions[element.id]! + 1;
        } else {
          uniqueTransactions[element.id] = 1;
        }
      }
    });

    reciverTransactionDetails.docs.forEach((element) {
      if (element.id != "ignore_this_collection") {
        if (uniqueTransactions.containsKey(element.id)) {
          uniqueTransactions[element.id] = uniqueTransactions[element.id]! + 1;
        } else {
          uniqueTransactions[element.id] = 1;
        }
      }
    });
    List<String> transactions = [];
    uniqueTransactions.forEach((key, value) {
      if (value == 2) {
        transactions.add(key);
      }
    });
    return transactions;
  }

  Future<TransactionModel> getTransactionFromTransactionID(
      String transactionID) async {
    DocumentSnapshot snap = await _firebaseFirestore
        .collection("transactions")
        .doc(transactionID)
        .get();

    return TransactionModel.fromSnapshot(snap);
  }
}
