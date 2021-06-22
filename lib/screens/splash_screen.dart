import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttersync/authentication/authentication.dart';
import 'package:fluttersync/screens/home_Page.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth _auth;
  User user ;

  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    
    user= _auth.currentUser;
    print(user);
    Timer(Duration(seconds: 4), () {
      //Navigator.of(context).pushReplacementNamed("/authenticationPage");
      
      (user==null)?Navigator.of(context).pushReplacementNamed("/authenticationPage"):Navigator.of(context).pushReplacementNamed("/welcome_page");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.indigoAccent[400],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Text(""),
              ),
              Expanded(
                flex: 6,
                child: Center(
                  child: Text(
                    "<Cry>pto",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: GoogleFonts.suezOne().fontFamily,
                    ),
                    textScaleFactor: 1.1,
                  ),
                ),
              ),
              Container(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              )),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "Even the word crypto begins with cry !",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.suezOne().fontFamily,
                      // fontWeight: FontWeight.bold,
                    ),
                    textScaleFactor: 1.3,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
