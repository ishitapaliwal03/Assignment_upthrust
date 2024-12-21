import 'dart:convert';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:assignment/screens/OtpScreen.dart';
class MobileLoginScreen extends StatefulWidget {
  @override
  _MobileLoginScreenState createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  String selectedCountryCode = '+91';
  String selectedCountryFlag = '🇮🇳';
  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  final List<Map<String, String>> countries = [
    {'name': 'India', 'flag': '🇮🇳', 'code': '+91'},
    {'name': 'USA', 'flag': '🇺🇸', 'code': '+1'},
    {'name': 'UK', 'flag': '🇬🇧', 'code': '+44'},
  ];

  void _showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Country',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return ListTile(
                    leading: Text(
                      country['flag']!,
                      style: TextStyle(fontSize: 24),
                    ),
                    title: Text(country['name']!),
                    trailing: Text(
                      country['code']!,
                      style: TextStyle(color: Colors.grey),
                    ),
                    onTap: () {
                      setState(() {
                        selectedCountryCode = country['code']!;
                        selectedCountryFlag = country['flag']!;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendPhoneNumber() async {
    final phoneNumber = phoneController.text.trim();
    if (phoneNumber.isEmpty || phoneNumber.length < 10) {
      _showErrorDialog('Invalid phone number.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://82.180.132.164:4000/api/appUser/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobileNumber': selectedCountryCode + phoneNumber}),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 && responseBody['status'] == true) {
        final otp = responseBody['data'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(
              otp: otp,
              mobileNumber: selectedCountryCode + phoneNumber,
            ),
          ),
        );
      } else {
        _showErrorDialog(responseBody['message'] ?? 'Failed to send OTP.');
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
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_circle_left_outlined,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Login with Mobile Number',
                  style: TextStyle(
                    fontSize: screenHeight * 0.024,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Mobile Number',
                  style: TextStyle(
                    fontSize: screenHeight * 0.017,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.0172),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.041),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => _showCountryPicker(context),
                        child: Row(
                          children: [
                            Text(
                              selectedCountryFlag,
                              style: TextStyle(fontSize: screenHeight * 0.022),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              selectedCountryCode,
                              style: TextStyle(
                                fontSize: screenHeight * 0.018,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter mobile number',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: isLoading ? null : sendPhoneNumber,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  minimumSize: Size(double.infinity, screenHeight * 0.06),
                ),
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                  'Verify',
                  style: TextStyle(
                    fontSize: screenHeight * 0.025,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
