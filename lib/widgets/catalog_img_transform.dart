import 'package:flutter/material.dart';
import 'package:fluttersync/widgets/resource.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/catalog_data.dart';
import 'package:flutter/services.dart';


class CatalogImgTransform extends StatefulWidget {
  final CatalogModel object;
  CatalogImgTransform({@required this.object});

  @override
  _CatalogImgTransformState createState() => _CatalogImgTransformState();
}

class _CatalogImgTransformState extends State<CatalogImgTransform> {
  var about;
  @override
  void initState() {
    super.initState();
    loadAbout();
  }

  loadAbout() async {
    //about = await rootBundle.loadString("assets/textfiles/Dogecoin.txt");
    about = await rootBundle
        .loadString("assets/textfiles/" + widget.object.title + ".txt");
    // print(about);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //print("about"+about );
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Color(int.parse("0xff"+object.color)),

        appBar: AppBar(
          backgroundColor: Color(int.parse("0xff" + widget.object.color)),
          elevation: 0,
          //toolbarHeight: 30,
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: Key(widget.object.id.toString()),
                  child: Container(
                    color: Color(int.parse("0xff" + widget.object.color)),
                    // margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(15),

                    child: Image.network(widget.object.image),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: Text(
                        widget.object.discription,
                        textScaleFactor: 2.0,
                        style: GoogleFonts.suezOne(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      alignment: Alignment.center,
                      child: Text(
                        about.toString(),
                        textScaleFactor: 1.2,
                      ),
                    ),
                    if(widget.object.title=="Resources")
                    ResourceUrl()

                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}








/* 

 ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Hero(
                tag: Key(object.id.toString()),
                child:Container(
                    color:Color(int.parse("0xff"+object.color)),
                   // margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(15),
                   
                    child: Image.network(object.image),
                  ),
                
              ),
              Column(
                children: [
                  Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                alignment: Alignment.topLeft,
                child: Text(
                  object.discription,
                  textScaleFactor: 2.0,
                  
                ),
              ),
                ],
              ),
            ],
          ),
        ],
      ),

















      NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              Hero(
                  tag: Key(object.id.toString()),
                  
                child: SliverAppBar(
                  expandedHeight: 300.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(object.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image.network(
                      object.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Column(
            children: [
              Container(
                color: Color(int.parse("0xff" + object.color)),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                alignment: Alignment.topLeft,
                child: Text(
                  object.discription,
                  textScaleFactor: 2.0,
                ),
              ),
            ],
          ),
        ),

*/