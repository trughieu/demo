import 'package:flutter/material.dart';

class Orders {
  int price;
  String title;
  String image;
  int id;
  Image? img;

  Orders(
      {required this.price,
      required this.title,
      required this.image,
      required this.id});

  factory Orders.fromJson(Map<String, dynamic> item) {
    return Orders(
      title: item['title'],
      image: item['image'],
      price: (item['price']),
      id: item['id'],
    );
  }
}
