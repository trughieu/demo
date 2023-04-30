import 'package:demo/model/oder.dart';

import 'products.dart';

class Cart {
  static List<Products> cart=[];
  void
   addProductsToCart(Products product){
    cart.add(product);
  }
  List<Products> getCart(){
    return cart;
  }
}