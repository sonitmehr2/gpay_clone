import 'package:flutter/material.dart';

import '../resources/utils.dart';

class UserProfileIcon extends StatelessWidget {
  final String name;
  final double radius;
  final Color backgroundColor;
  const UserProfileIcon({
    super.key,
    required this.name,
    required this.radius,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 40,
        height: 40,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: backgroundColor,
          child: Text(name.substring(0, 1).toUpperCase()),
        ),
      ),
    );
  }
}
