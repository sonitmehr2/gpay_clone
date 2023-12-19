import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String name;

  User({
    required this.uid,
    required this.name,
  });
  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    String uid = snapshot.id;
    String name = snapshot['name'] ?? '';

    return User(
      uid: uid,
      name: name,
    );
  }
}
