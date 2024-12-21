import 'dart:async';

import 'package:assignment/screens/LandingPage.dart';
import 'package:flutter/material.dart';
class SuccessScreen extends StatefulWidget {
  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 1),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  LandingPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: screenWidth * 0.2,
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'Login Successful!',
              style: TextStyle(
                fontSize: screenHeight * 0.03,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
