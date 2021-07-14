import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttersync/widgets/catalog_img_transform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/catalog_data.dart';

class CatalogDataTransform extends StatefulWidget {
  @override
  _CatalogDataTransformState createState() => _CatalogDataTransformState();
}

class _CatalogDataTransformState extends State<CatalogDataTransform> {
  int index = 0;
  @override
  void initState() {
    super.initState();

    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 0));
    var catalogJson = await rootBundle.loadString("assets/catalogdata.json");

    //print(catalogJson);
    var decodedJson = jsonDecode(catalogJson);
    //print(decodedJson);
    var topicData = decodedJson["topics"];
    // print("about " + topicData[index]["about"]);
    // var about = await rootBundle.loadString("${topicData[index]["about"]}");
    // print(topicData);

    CatalogData.itemList = List.from(topicData)
        .map((e) => CatalogModel.fromMap(e))
        .toList();
    setState(() {
      if (index < 5) {
        index++;
      } else {
        index = 0;
      }
    });

    print(CatalogData.itemList.runtimeType);
  }

  Widget build(BuildContext context) {
    return (CatalogData.itemList.isEmpty || CatalogData.itemList == null)
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
        : GridView.count(
            crossAxisCount: 2,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.all(20),
            crossAxisSpacing: 20,
            mainAxisSpacing: 10,
            children: [
              ...CatalogData.itemList.map((e) {
                return Card(
                  elevation: 5,
                  //shadowColor: Colors.indigo,
                  //color: Colors.redAccent,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(5),
                    ),
                  ),
                  child: Hero(
                    tag: Key(e.id.toString()),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration: Duration(seconds: 1),
                            pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) {
                              return CatalogImgTransform(object: e);
                            },
                          ),
                        );
                      },
                      child: Stack(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            // height:120,
                            // width: 400,
                            margin: EdgeInsets.only(top: 40),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(e.image),
                                fit: BoxFit.contain,
                                
                                // scale: 1.4
                              ),
                              gradient: LinearGradient(
                                  colors: [Colors.indigo, Colors.redAccent]),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                              padding: EdgeInsets.only(
                                  top: 7, bottom: 15, right: 7, left: 3),
                              //margin: EdgeInsets.only(top: 7,bottom: 10,right: 7),
                              child: FittedBox(
                                  child: Text(
                                e.title,
                                style: TextStyle(fontSize: 20),
                              ))),
                        ],
                      ),
                    ),
                  ),
                );

                // Card(
                //   child:
                //   ListTile(
                //     title: Text(e.title ?? ""),
                //     subtitle: Text(e.discription ?? ""),
                //     // leading: Text(e.id.toString()),
                //     //tileColor: Color(int.parse("0xff" + e.color)),
                //     leading: Image.network(e.image),
                //   ),
                // );
              }).toList()
            ],
          );
  }
}

/*

  @override
  Widget build(BuildContext context) {
    return (CatalogData.itemList.isEmpty || CatalogData.itemList == null)
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
        : GridView.count(
            crossAxisCount: 1,
            
            physics: ScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.all(20),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            
            children: [
              ...CatalogData.itemList.map((e) {
                
                return StreamBuilder(
        initialData: false,
        stream: slimyCard.stream,
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.data);
          return ListView(
            shrinkWrap: true,
            
            reverse: true,
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            children: <Widget>[
              //SizedBox(height: 70),
              SlimyCard(
                topCardHeight: 280,
                bottomCardHeight: 130,
                borderRadius:25,
                
                //slimeEnabled: false,
                color: Colors.indigo[300],
                topCardWidget: topCardWidget(
                  //(snapshot.data)
                    // ? 'assets/images/devs.jpg'
                    // : 'assets/images/flutter.png'
                    e.image),
                bottomCardWidget: bottomCardWidget(),
              ),
              
            ],
          );
        }),
      );
                // ListTile(
                //   title: Text(e.title ??""),
                //   subtitle: Text(e.discription??""),
                //   // leading: Text(e.id.toString()),
                //   tileColor:Color(int.parse("0xff"+e.color)),
                //   leading: Image.network(e.image),

                // );
              }).toList()
            ],
          );
  }
}







  Widget topCardWidget(String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: NetworkImage(imagePath),fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Text(
          'Flutter',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(height: 15),
        Center(
          child: Text(
            'Flutter is Google’s UI toolkit for building beautiful, natively compiled applications'
                ' for mobile, web, and desktop from a single codebase.',
            style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }


 Widget bottomCardWidget() {
    return Column(
      children: [
        Text(
          'https://flutterdevs.com/',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 15),
        Expanded(
          child: Text(
            'FlutterDevs specializes in creating cost-effective and efficient '
                'applications with our perfectly crafted,creative and leading-edge '
                'flutter app development solutions for customers all around the globe.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }


*/
