import 'dart:ui';

import 'package:fascinations_app/contants.dart';
import 'package:fascinations_app/pages/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/assets/img/bg.png'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight / 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "FasciNations",
                  style: GoogleFonts.aclonica(
                    textStyle: kTittleStyle,
                    fontSize: screenWidth * 0.12,
                  ),
                ),
                sizedbox(2),
                Text(
                  "Explore Flags, Test Your Knowledge!",
                  style: GoogleFonts.aBeeZee(
                      textStyle: kLittleTittleStyle,
                      fontSize: screenWidth * .05),
                ),
                sizedbox(14),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: .5, sigmaY: .5),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF0C9281),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(159),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Game()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16, left: 16),
                      child: Text(
                        "Start",
                        style: GoogleFonts.fugazOne(
                          textStyle: kButtonStyle,
                          fontSize: screenWidth * .08,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox sizedbox(double height) {
    return SizedBox(
      height: height,
    );
  }
}
