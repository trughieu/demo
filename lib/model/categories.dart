import 'package:flutter/material.dart';

class Categories {
  int id;
  String title;
  String image;
  Image? img;

  Categories({required this.id, required this.title, required this.image});

  factory Categories.fromJson(Map<String,dynamic> item) {
    return Categories(
      title: item['title'],
      image: item['image'],
      id: item['_id']
    );
  }

  @override
  String toString() {
    return 'Categories{id: $id, title: $title, image: $image, img: $img}';
  }

// static List<Categories> init(){
//   Future<List<Categories>> data= Utilities().getCate() ;
//   // [
//   //   Categories(id: 1,title: "HighLand",image:"asset/images/ic_highland.jpeg" ),
//   //   Categories(id: 2,title: "HighLand",image:"asset/images/ic_circlek.png" ),
//   //   Categories(id: 3,title: "HighLand",image:"asset/images/ic_ministop.png" ),
//   //   Categories(id: 4,title: "HighLand",image:"asset/images/ic_seveneleven.png" ),
//   //   Categories(id: 5,title: "HighLand",image:"asset/images/ic_vinmart.png" )
//   //
//   // ];
//   return <Categories>[];
// }
}
