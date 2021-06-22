import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttersync/widgets/dashboard_data_transform.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  Widget circularProgress = CircularProgressIndicator();
  void initState() {
    super.initState();
    // () async {
    //   await Future.delayed(Duration(seconds: 2));
    // };
  }

  @override
  Widget build(BuildContext context) {
    return
           
               Container(
                  //margin: EdgeInsets.only(bottom: 150,),
                 
                  child: DashboardDataTransform(),
            );
  }
}
