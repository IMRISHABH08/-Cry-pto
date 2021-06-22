import 'package:flutter/material.dart';
import '../widgets/catalog_data_transform.dart';

class Catalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
         
              
          //gradient: LinearGradient(colors: [Colors.indigo[300], Colors.indigo]),
         
        ),
        child: CatalogDataTransform());
  }
}
