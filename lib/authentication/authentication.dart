import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:fluttersync/screens/home_Page.dart';

enum MobileVerificationState { EMAIL_FORMSTATE, OTP_FORMSTATE }

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  var currentState = MobileVerificationState.EMAIL_FORMSTATE;

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController OTPController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;
  String MobNo;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  bool showLoading = false;

  @override
  void initState() {
    phoneNumberController.addListener(() {
      print("value in phoneTextField:${phoneNumberController.text}");
      MobNo = phoneNumberController.text;
      print("value in MOBNO:$MobNo");
    });
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    // TODO: implement dispose
    super.dispose();
     print("value in MOBNO_dis:$MobNo");
  }

  void signWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      print("authCredential Created");

      setState(() {
        showLoading = false;
      });

      if (authCredential?.user != null) {
        Navigator.of(context).pushReplacementNamed("/welcome_page");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Welcome !"),
          duration: Duration(seconds: 1),
        ),
      );
      // _scaffoldKey.currentState.showSnackBar(SnackBar(
      //   content: Text("Welcome HomePage!!"),
      // ));
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      // _scaffoldKey.currentState.showSnackBar(SnackBar(
      //   content: Text("FireBaseAuth Exception occured :" + e.message),
      // ));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Wrong OTP !"),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.blue,
        ),
      );
      //await Future.delayed(Duration(seconds: 1));
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/authenticationPage", (route) => false);
    }
  }

  getMobileFormWidget(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(),
        Container(
            height: MediaQuery.of(context).size.height * 0.30,
            child: Image.asset(
              "assets/images/OTP_SEND.png",
            )),
        Text("We will send OTP to this number",
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
        Text(
          "Let's Verify",
          style: TextStyle(color: Colors.black54),
        ),
        Row(children: [
          Expanded(
            flex: 2,
            child: TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                  labelText: "Enter Phone Number",
                  hintText: "e.x. 8987675643",
                  hintStyle: TextStyle(
                    fontSize: 14,
                  )

                  //border: ,)
                  ),
              keyboardType: TextInputType.number,
              //maxLength: 10,
            ),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black12,
                  primary: Colors.blue,
                ),
                onPressed: (MobNo == null ||
                        MobNo.isEmpty ||
                        MobNo.length != 10)
                    ? () {
                         setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Enter Number !"),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.blue,
                          ),
                        );
                      }
                    : () async {
                        setState(() {
                          showLoading = true;
                        });

                        await _auth.verifyPhoneNumber(
                          phoneNumber: "+91" + phoneNumberController.text,
                          verificationCompleted: (phoneAuthCredential) async {
                            setState(() {
                              showLoading = false;
                            });
                            //await _auth.signInWithCredential(phoneAuthCredential);
                            print("verification completed");
                          },
                          verificationFailed: (firebaseAuthException) async {
                            setState(() {
                              showLoading = false;
                              print("verification failed");
                            });
                            // return _scaffoldKey.currentState.showSnackBar(
                            //   SnackBar(
                            //     content: Text("verificationFailed.message"),
                            //     duration: Duration(seconds: 3),
                            //   ),
                            // );

                            return ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Vrification Failed!"),
                                duration: Duration(seconds: 3),
                                backgroundColor: Colors.blueAccent,
                              ),
                            );
                          },
                          codeSent: (verificationId, resendingToken) async {
                            setState(() {
                              showLoading = false;
                              currentState =
                                  MobileVerificationState.OTP_FORMSTATE;
                              this.verificationId = verificationId;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("OTP Sent Successfully!"),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.blueAccent,
                                ),
                              );
                              print("code sent");
                            });
                          },
                          codeAutoRetrievalTimeout: (verificationId) async {},
                        );
                      },
                child: Text("Send OTP")),
          ),
        ]),
        Spacer(),
      ],
    );
  }

  getOTPFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        Image.asset("assets/images/OTP_VERIFICATION.png"),
        RichText(
            text: TextSpan(
                text: "We have Successfully sent the OTP to ",
                style: TextStyle(color: Colors.black87),
                children: [
              TextSpan(
                text: phoneNumberController.text.toString(),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              )
            ])),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                controller: OTPController,
                decoration: InputDecoration(
                    labelText: "Enter OTP",
                    hintText: "e.x. 123456",
                    hintStyle: TextStyle(
                      fontSize: 14,
                    )),
                keyboardType: TextInputType.number,
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                onPressed: () {
                  final PhoneAuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: OTPController.text);
                  print(
                      "verification button pressed for OTP and signinWithPhoneAuthCredential is called");
                  signWithPhoneAuthCredential(phoneAuthCredential);
                },
                child: Text("Verify OTP"),
              ),
            ),
          ],
        ),
        Spacer(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(15),
        child: showLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : currentState == MobileVerificationState.EMAIL_FORMSTATE
                ? getMobileFormWidget(context)
                : getOTPFormWidget(context),
      ),
    );
  }
}
