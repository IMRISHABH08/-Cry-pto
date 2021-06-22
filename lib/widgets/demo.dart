
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// This is the main application widget.
class MyApp extends StatefulWidget {
  static String _title = 'Flutter Code Sample';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _snap = true;
  bool _floating = true;
  bool _pinned = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp._title,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: _pinned,
                snap: _snap,
                floating: _floating,
                expandedHeight: 160.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('SliverAppBar'),
                  background: FlutterLogo(),
                ),
                bottom: TabBar(tabs: [Icon(Icons.add), Icon(Icons.power)]),
              ),
              
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      color: index.isOdd ? Colors.white : Colors.black12,
                      height: 100.0,
                      child: Center(
                        child: Text('$index', textScaleFactor: 5),
                      ),
                    );
                  },
                  childCount: 20,
                ),
              ),
            ],
          ),
          
        ),
      ),
    );
  }
}
