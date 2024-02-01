// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gpay_clone/screens/home_screen.dart';
import 'package:gpay_clone/services/firebase_auth_mehtods.dart';

class SignUpScreen extends StatefulWidget {
  final String email;
  final String password;
  const SignUpScreen({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _upiIDController = TextEditingController();

  Future<void> signUpUser(
      String email, String password, String name, String upiID) async {
    await FirebaseAuthMehthods()
        .signUpUser(email, password, name, upiID, "Sign-in Screen");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text = widget.email;
    _passwordController.text = widget.password;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _upiIDController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("SIGN-UP-SCREEN"),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: "Email", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    hintText: "Password", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    hintText: "Name", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _upiIDController,
                decoration: InputDecoration(
                    hintText: "Upi ID", border: OutlineInputBorder()),
              ),
            ),
            ElevatedButton(
                onPressed: () async => signUpUser(
                    _emailController.text,
                    _passwordController.text,
                    _nameController.text,
                    _upiIDController.text),
                child: const Text('Sign Up'))
          ],
        ),
      ),
    );
  }
}
