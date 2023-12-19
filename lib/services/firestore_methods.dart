import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gpay_clone/models/transaction_model.dart';
import 'package:gpay_clone/models/user_model.dart' as model;

class FireStoreMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<model.User> getUserDetails(String uid) async {
    DocumentSnapshot snap =
        await _firebaseFirestore.collection('users').doc(uid).get();
    return model.User.fromSnapshot(snap);
  }

  Future<void> addTransactionDetails(
      String sender_id, String reciever_id, String amount) async {
    String time = DateTime.now().toString();
    TransactionModel transactionModel = TransactionModel(
        amount: amount,
        sender_id: sender_id,
        reciever_id: reciever_id,
        time: time);
    DocumentReference transaction = await _firebaseFirestore
        .collection('transactions')
        .add(transactionModel.toJson());

    String transaction_id = transaction.id;

    await _firebaseFirestore.collection("users").doc(sender_id).set({
      'transaction_history': FieldValue.arrayUnion([transaction_id])
    }, SetOptions(merge: true));
    await _firebaseFirestore.collection("users").doc(reciever_id).set({
      'transaction_history': FieldValue.arrayUnion([transaction_id])
    }, SetOptions(merge: true));
  }
}
