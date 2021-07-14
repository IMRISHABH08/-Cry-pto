import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersync/authentication/authentication.dart';
import 'package:fluttersync/screens/welcome_page.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final _auth = FirebaseAuth.instance;
  String user;
  String email;
  var ref;
  initState() {
    super.initState();

    ref = FirebaseDatabase.instance
        .reference()
        .child("my_app_user")
        .child(_auth.currentUser.uid);

    valuefetch();
    // ref.child("Name").once().then((DataSnapshot data) {
    //   setState(() {
    //     user = data.value;
    //     print("USER:"+user);
    //   });
    // });
    // ref.child("Email").once().then((DataSnapshot data) {
    //   setState(() {
    //     email = data.value;
    //     print("EMAIL:"+email);
    //   });
    // });
  }

  valuefetch() async {
    await ref.once().then((value) {
      Map<dynamic, dynamic> values = value.value ?? {};
      user = values["Name"] ?? "";
      email = values["Email"] ?? "";
    });
    setState(() {});
  }

  Widget build(BuildContext context) {
    final img =
        "https://cdn.dribbble.com/users/458522/screenshots/4611234/deadpool.jpg?compress=1&resize=800x600";

    print("current user" + _auth.currentUser.toString());
    return Drawer(
        child: Container(
      color: Colors.indigoAccent[400],
      child: ListView(
          //physics: BouncingScrollPhysics(),
          children: [
            Theme(
              data: ThemeData(primaryColor: Colors.indigoAccent[400]),
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                //decoration: BoxDecoration(color:Theme.of(context).accentColor),
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,
                  accountName: Text(user??""

                      //   {
                      // ref.once().then((data) => () {
                      //       Map<dynamic, dynamic> values = data.value;
                      //       print("values"+values.toString());
                      //         // values.forEach(
                      //         //   (key, values) {
                      //         //     return ("values :" + values["Name"]);
                      //         //   },
                      //         // );
                      //         // return values["Name"];
                      //         //values.
                      //         return ("values :" + values["Name"]);
                      //       })
                      // }.toString(),
                      ),
                  accountEmail: Text(email??""),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                      img,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.white),
                textScaleFactor: 1.3,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.mail,
                color: Colors.white,
              ),
              onTap: () {
                print("hello mail");
                //Navigator.of(context).pop();
              },
              title: Text(
                "E-mail",
                style: TextStyle(color: Colors.white),
                textScaleFactor: 1.3,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.pushReplacementNamed(context, "/welcome_page");
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => WelcomePage()));
                //Navigator.of(context).pushNamed("/welcome_page");
              },
              leading: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.white,
              ),
              title: Text(
                "Profile Edit",
                style: TextStyle(color: Colors.white),
                textScaleFactor: 1.3,
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.power,
              ),
              title: Text(
                "Sign Out",
                style: TextStyle(color: Colors.white),
                textScaleFactor: 1.3,
              ),
              onTap: () async {
                await _auth.signOut();
                //Navigator.of(context).pushNamedAndRemoveUntil("/authenticationPage", (Route<dynamic> route) => false);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => AuthenticationPage()));
              },
            )
          ]),
    ));
  }
}
