import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnderDevelopmentScreen extends StatefulWidget {
  const UnderDevelopmentScreen({super.key});

  @override
  State<UnderDevelopmentScreen> createState() => _UnderDevelopmentScreenState();
}

class _UnderDevelopmentScreenState extends State<UnderDevelopmentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.construction,
              size: 30,
            ),
            Text(
              'This page is under development',
              style: GoogleFonts.notoSansKhojki(
                textStyle: const TextStyle(
                  fontSize: 17, // Example font size
                  fontWeight: FontWeight.w400, // Example font weight
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
