import 'package:assignment/screens/SuccessScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OtpScreen extends StatefulWidget {
  final String otp;
  final String mobileNumber;

  OtpScreen({required this.otp, required this.mobileNumber});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    otpController.text = widget.otp; // Pre-fill OTP for testing
  }

  Future<void> _verifyOtp() async {
    final otp = otpController.text.trim();
    if (otp.isEmpty || otp.length != 6) {
      _showErrorDialog('Invalid OTP. Please enter a 6-digit code.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://82.180.132.164:4000/api/appUser/auth/verifyOtp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobileNumber': widget.mobileNumber, 'otp': otp}),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 && responseBody['status'] == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessScreen(), // Navigate to a success screen
          ),
        );
      } else {
        _showErrorDialog(responseBody['message'] ?? 'Failed to verify OTP.');
      }
    } catch (e) {
      _showErrorDialog('An error occurred. Please try again.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_circle_left_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Verify Your Mobile Number',
                  style: TextStyle(
                    fontSize: screenHeight * 0.024,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Enter OTP Sent to +91 ${widget.mobileNumber}',
                  style: TextStyle(
                    fontSize: screenHeight * 0.016,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return Container(
                    height: screenHeight * 0.06,
                    width: screenHeight * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: TextEditingController(
                          text: otpController.text.length > index
                              ? otpController.text[index]
                              : ""),
                      enabled: false,
                      style: TextStyle(fontSize: screenHeight * 0.025,color: Colors.black),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  );
                }),
              ),
              Spacer(),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Resend OTP Logic
                  },
                  child: Text(
                    'Didn’t receive OTP? Resend OTP',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: screenHeight * 0.018,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: isLoading ? null : _verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size(double.infinity, screenHeight * 0.07),
                ),
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: screenHeight * 0.025,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
