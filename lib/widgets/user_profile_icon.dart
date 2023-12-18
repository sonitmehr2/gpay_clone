import 'package:flutter/material.dart';

class UserProfileIcon extends StatelessWidget {
  final String imageAsset;
  final double radius;
  const UserProfileIcon(
      {super.key, required this.imageAsset, required this.radius});

  @override
  Widget build(BuildContext context) {
    // return Text('hello');
    return CircleAvatar(
      radius: radius,
      backgroundImage: AssetImage(imageAsset),
    );
  }
}
