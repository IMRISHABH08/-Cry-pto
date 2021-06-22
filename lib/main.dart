import 'dart:async';

import 'package:fluttersync/provider/currency_provider.dart';
import 'package:fluttersync/screens/welcome_page.dart';
import 'package:fluttersync/widgets/dashboard_data_transform.dart';
import 'package:provider/provider.dart';

import '../widgets/dashboard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttersync/authentication/authentication.dart';
import 'package:fluttersync/screens/home_Page.dart';
import './screens/splash_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlutterSync());
}

class FlutterSync extends StatefulWidget {
  @override
  FlutterSyncState createState() => FlutterSyncState();
}

class FlutterSyncState extends State<FlutterSync> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>CurrencyProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blueAccent,
        accentColor: Colors.deepPurple,
        fontFamily: GoogleFonts.poppins().fontFamily),
        initialRoute: "/",
        routes: {
          "/": (context) => SplashScreen(),
          "/authenticationPage": (context) => AuthenticationPage(),
          "/home_page":(context)=>Home_Page(),
          "/dash_board":(context)=>DashBoardPage(),     
          "/Dashboard_data_transform":(context)=>DashboardDataTransform(),   //"//d":(context)=>MyApp(),
          "/welcome_page":(context)=>WelcomePage(),
        },
        
      ),
    );
  }
}
