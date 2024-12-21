import 'package:assignment/customized_widgets/Custombutton.dart';
import 'package:assignment/login/Loginwithphonenumber.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Loginoptions extends StatelessWidget {
  const Loginoptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage("assets/images/loginbackground.png"),
                opacity: 0.08,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  SizedBox(height: screenHeight * 0.15),
                  Image.asset(
                    "assets/images/app_logo.png",
                    height: screenHeight * 0.2,
                    width: screenWidth * 0.4,
                  ),

                  SizedBox(height: screenHeight * 0.08),
                  Text(
                    'Get Started!',
                    style: GoogleFonts.inter(
                      fontSize: screenHeight * 0.03,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  CustomButton(
                    text: 'Continue with Google',
                    imagePath: 'assets/images/google.png',
                    onPressed: () {
                      print('Google button pressed');
                    },
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  CustomButton(
                    text: 'Continue with Apple',
                    imagePath: 'assets/images/applee.png',
                    onPressed: () {
                      print('Apple button pressed');
                    },
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  CustomButton(
                    text: 'Continue with Mobile Number',
                    imagePath: 'assets/images/smartphone.png',
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>  Loginwithphonenumber()),
                      );
                    },
                  ),

                  const Spacer(flex: 2),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.1),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(color: Colors.black54, fontSize: screenHeight * 0.015),
                        children: [
                          TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'Terms & Condition',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
