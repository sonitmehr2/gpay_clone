import 'package:flutter/material.dart';

class RecentPeopleIcon extends StatelessWidget {
  final String name;
  final double width;
  final double height;
  final double radius;
  final Color backgroundColor;
  const RecentPeopleIcon({
    super.key,
    required this.name,
    required this.width,
    required this.height,
    required this.radius,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            CircleAvatar(
              radius: radius,
              backgroundColor: backgroundColor,
              child: Text(name.substring(0, 1).toUpperCase()),
            ),
            Text(name),
          ],
        ),
      ),
    );
  }
}
