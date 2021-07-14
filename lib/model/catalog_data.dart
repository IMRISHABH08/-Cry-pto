import 'package:flutter/material.dart';

class CatalogModel {
  final int id;
  final String title;
  final String discription;
  final String about;
  final String color;
  final String image;

  CatalogModel(
      {this.id,
      this.title,
      this.discription,
      this.about,
      this.color,
      this.image});

  factory CatalogModel.fromMap(Map<String, dynamic> map) {
    return CatalogModel(
        id: map["id"],
        title: map["title"],
        discription: map["discription"],
        about: map["about"],
        color: map["color"],
        image: map["image"]);
  }

  toMap() => {
        "id": id,
        "title": title,
        "discription": discription,
        "about": about,
        "color": color,
        "image": image,
      };
}

class CatalogData {
  static final String aboutId_1 =
      "Cryptocurrency is a type of digital currency that generally only exists electronically. There is no physical coin or bill unless you use a service that allows you to cash in cryptocurrency for a physical token.";

  static List<CatalogModel> itemList = [];
}
