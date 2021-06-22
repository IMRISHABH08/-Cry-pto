import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttersync/screens/home_Page.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String addName = " ";
  bool buttonIsOn = false;
  bool autoFocusName = false;
  bool autoFocusPasswd = false;
  String user_name;
  String email;

  FirebaseAuth _auth;
  final fb = FirebaseDatabase.instance;
  final _formKey = GlobalKey<FormState>();

  moveTohomePage(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        buttonIsOn = true;
      });
      fbDataStore();

      print("Button is $buttonIsOn");
      await Future.delayed(Duration(milliseconds: 1500));
      await Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return Home_Page(user_name: user_name, email: email);
      }), (route) => false);
      // await Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return Home_Page(user_name: user_name, email: email);
      // }));
      buttonIsOn = false;
      setState(() {});
    }
  }

  fbDataStore() async {
    _auth = FirebaseAuth.instance;
    final ref = fb.reference();
    //await ref.child("myApp_user").child(_auth.currentUser.uid).child("Name").set(user_name);
    // ref.child("myAppUser").push().child("Name").set(user_name).asStream();
    ref
        .child("my_app_user")
        .child(_auth.currentUser.uid)
        .set({"Name": user_name, "Email": email});
  }



  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          reverse: true,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    //height: 400,
                    //margin: EdgeInsets.all(20),
                    child: Image.network(
                      "https://drive.google.com/uc?export=view&id=1SXZgqcU2yzrEkau-w76By0fS1Asu2avh",
                      fit: BoxFit.cover,
                    ),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Container(
                    // width: 200,
                    // height: 100,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.all(
                    //     Radius.circular(30),
                    //   ),
                    // ),
                    child: Text(
                      "  Welcome $addName ",
                      style: GoogleFonts.poppins(
                          fontStyle: FontStyle.italic,
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold),
                      textScaleFactor: 1.5,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32),
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              addName = value;
                            });
                          },

                          validator: (value) {
                            if (value.isEmpty) return "Enter UserName";
                            setState(() {
                              user_name = value;
                            });
                            return null;
                          },
                          autofocus: autoFocusName,
                          // controller: TextEditingController(),
                          decoration: InputDecoration(
                            //  border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(25),
                            //   borderSide: BorderSide.none,
                            // ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25)),
                            labelText: "Username",
                            // floatingLabelBehavior:,
                            hintText: "e.g. Rishabh",
                            hintStyle: TextStyle(fontSize: 10),
                            filled: true,
                            fillColor: Colors.blue[100],
                          ),
                          keyboardType: TextInputType.name,

                          //onSubmitted: (_){},

                          // inputFormatters: [
                          //   FilteringTextInputFormatter.allow(filterPattern)
                          // ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty || value.contains('@') == false)
                              return "Use proper E-mail id";

                            //else
                            setState(() {
                              email = value;
                            });
                            return null;
                          },

                          autofocus: autoFocusPasswd,
                          decoration: InputDecoration(
                            labelText: "E-mail",
                            hintText: "e.x. xyz@email.com",
                            hintStyle: TextStyle(fontSize: 10),
                            filled: true,
                            fillColor: Colors.blue[100],

                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25)),

                            //errorText: "For validation",
                          ),
                          keyboardType: TextInputType.emailAddress,

                          // onSubmitted: ,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Material(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(buttonIsOn ? 50 : 10),
                    child: InkWell(
                      splashColor: Colors.blue,
                      onTap: () {
                        moveTohomePage(context);
                        //await Future.delayed(Duration(seconds: 2));
                        // buttonIsOn = false;
                        // print("Button is $buttonIsOn");
                        // setState(() {});
                      },
                      child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          alignment: Alignment.center,
                          height: 50,
                          width: buttonIsOn ? 50 : 70,
                          // decoration: BoxDecoration(
                          //   color: Colors.deepPurple,
                          // borderRadius:
                          //     BorderRadius.circular(buttonIsOn ? 50 : 10),
                          //shape: buttonIsOn?BoxShape.circle:BoxShape.rectangle,

                          child: buttonIsOn
                              ? Icon(
                                  Icons.done,
                                  color: Colors.white,
                                )
                              : Icon(
                                  CupertinoIcons.arrow_right,
                                  //  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                )
                          // Text(
                          //     "Login",
                          //     style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 20,
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          ),
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   child: Text("Login"),
                  //   style: ElevatedButton.styleFrom(),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
