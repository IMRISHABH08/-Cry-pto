import 'dart:ui';

import 'package:fluttersync/widgets/drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersync/widgets/dashboard.dart';
import '../widgets/catalog.dart';

class Home_Page extends StatefulWidget {
  String user_name;
  String email;

   Home_Page({this.user_name, this.email});
  @override
  _Home_PageState createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  //final GlobalKey<ScaffoldMessengerState> _scaffoldkey = GlobalKey<ScaffoldMessengerState>();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    print("Run Time Type of auth" + _auth.runtimeType.toString());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primaryColor: Colors.indigoAccent[400],
        accentColor: Colors.indigoAccent[400],
        fontFamily: GoogleFonts.poppins().fontFamily,
        //accentColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          //backgroundColor: Colors.deepPurple,
          drawer:MyDrawer(user_name: widget.user_name, email: widget.email),
          // appBar: AppBar(
          //   actions: [
          //     IconButton(
          //       onPressed: () async {
          //         await _auth.signOut();
          //         Navigator.of(context).pushNamed("/authenticationPage");
          //       },
          //       icon: Icon(CupertinoIcons.power),
          //     ),
          //   ],
          //   title: Text("HomePage"),

          //   bottom:

          // ),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  title: Text("Home"),
                  floating: true,
                  pinned: true,
                  snap:
                      true, // <--- this is required if I want the application bar to show when I scroll up
                  bottom: new TabBar(
                    labelColor: Colors.redAccent,
                    unselectedLabelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.amberAccent,

                    // indicator: BoxDecoration(
                    //     gradient: LinearGradient(
                    //         colors: [Colors.redAccent, Colors.orangeAccent]),
                    //     borderRadius: BorderRadius.circular(50),
                    //     color: Colors.white),

                    indicator: BoxDecoration(
                        // gradient: LinearGradient(
                        //     colors: [Colors.redAccent, Colors.orangeAccent],
                        //     stops: [0.05,0.09],
                        //     ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        //shape: BoxShape.rectangle,
                        color: Colors.white),

                    tabs: [
                      Tab(
                        icon: Icon(Icons.article_outlined),
                        text: "      catalog     ",
                      ),
                      Tab(
                        icon: Icon(Icons.dashboard),
                        text: "   Dashboard   ",
                      )
                    ],
                  ), // <-- total of 2 tabs
                ),
              ];
            },
            body: TabBarView(children: [
              Catalog(),
              DashBoardPage(),
            ]),
          ),
        ),
      ),
    );
  }
}

/*




body: new NestedScrollView(
      headerSliverBuilder:
          (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          new SliverAppBar(
            title: Text("Application"),
            floating: true,
            pinned: true,
            snap: true,    // <--- this is required if I want the application bar to show when I scroll up
            bottom: new TabBar(

              labelColor: Colors.redAccent,
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.amberAccent,


              // indicator: BoxDecoration(
              //     gradient: LinearGradient(
              //         colors: [Colors.redAccent, Colors.orangeAccent]),
              //     borderRadius: BorderRadius.circular(50),
              //     color: Colors.white),


              indicator: BoxDecoration(
                  // gradient: LinearGradient(
                  //     colors: [Colors.redAccent, Colors.orangeAccent],
                  //     stops: [0.05,0.09],
                  //     ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  //shape: BoxShape.rectangle,
                  color: Colors.white),

              tabs: [
                Tab(
                  icon: Icon(Icons.article_outlined),
                  text: "      catalog     ",
                ),

                

                Tab(
                  icon: Icon(Icons.dashboard),
                  text: "   Dashboard   ",
                )

              ],

            ),    // <-- total of 2 tabs
            ),
          ),
        ];
      },




*/
