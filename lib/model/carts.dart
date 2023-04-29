import 'package:demo/model/oder.dart';

import 'products.dart';
class Cart {
  static List<Orders> cart=[];
  void
   addProductsToCart(Orders product){
    cart.add(product);
  }
  List<Orders> getCart(){
    return cart;
  }
}