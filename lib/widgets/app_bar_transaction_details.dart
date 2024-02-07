import 'package:flutter/material.dart';

class AppBarTransactionDetails extends StatelessWidget
    implements PreferredSizeWidget {
  final String name;
  final String hexColor;
  const AppBarTransactionDetails({
    super.key,
    required this.name,
    required this.hexColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(name),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
