import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class ResourceUrl extends StatelessWidget {
  final String url =
      "https://medium.com/coinmonks/the-biggest-ultimate-2020-cryptocurrency-resource-list-300-resources-4523e47f298";
  
  void _urlLauncher()async{
     if (await canLaunch(url)) {
    await launch(url,forceWebView:true);
  } else {
    throw 'Could not launch $url';
  }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          onPressed: _urlLauncher,
          child: Text("Resources",textScaleFactor:1.2,),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue[600],
            textStyle: GoogleFonts.suezOne(),
            
          ),
          
        ),
      ),
    );
  }
}
