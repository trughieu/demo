import 'dart:convert';

import 'package:demo/model/products.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiver/strings.dart';

class Utilities {
  static String url = "http://172.20.82.205:8000";
  static List<Products> products = [];
  static List<Products> data = [];

  Future<List<Products>> getProducts() async {
    var res = await http.get(Uri.parse('$url/api/foods'));
    if (res.statusCode == 200) {
      var content = res.body;
      var arr = json.decode(content)['food'] as List;
      products.addAll(arr.map((e) => Products.fromJson(e)).toList());
      //
      //   // Load images
      for (int i = 0; i < products.length; i++) {
        products[i].img =
            Image.network('$url/${products[i].image}');
      }
      return products;
    }
    return <Products>[];
  }

  List<Products> find(String value) {
    // getProducts().then((updatedProducts) {
    //   // Cập nhật danh sách products với dữ liệu mới
    //   products = updatedProducts;
    // });
    print(value);
    print(products.length);
    return products
        .where((p) => p.category.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }

  //
  // Future<List<Categories>> getCate() async {
  //   var res = await http.get(Uri.parse(url_cate));
  //   if (res.statusCode == 200) {
  //     var content_cate = res.body;
  //     print("abc " + content_cate.toString());
  //     var arr = json.decode(content_cate)['category'] as List;
  //     return arr.map((e) => Categories.fromJson(e)).toList();
  //   }
  //   return <Categories>[];
  // }
  //
  // Categories _fromJsonCate(Map<String, dynamic> item) {
  //   return Categories(
  //     title: item['title'],
  //     image: item['image'],
  //     id: item['_id'],
  //   );
  // }

  // Products _fromJson(Map<String, dynamic> item) {
  //   return Products(
  //     description: item['description'],
  //     title: item['title'],
  //     image: item['image'],
  //     price: (item['price']),
  //     id: 1,
  //   );
  // }

  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter mail';
    }

    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\'
        r']\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,'
        r'3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|((['
        r'a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 8) {
      return 'Password should be more than 8 characters';
    }
    return null;
  }

  static String? confirmPassword(String value, String value2) {
    if (!equalsIgnoreCase(value, value2)) {
      return 'Confirm Password invalid';
    }
    return null;
  }
}
