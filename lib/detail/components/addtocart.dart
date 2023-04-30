import 'package:demo/model/products.dart';
import 'package:demo/model/utilities.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../model/carts.dart';

class AddProductToCart extends StatefulWidget {
  // const AddProductToCart({Key? key}) : super(key: key);
   Products product;

  AddProductToCart({required this.product});

  @override
  State<AddProductToCart> createState() => _AddProductToCartState();
}

class _AddProductToCartState extends State<AddProductToCart> {
  // List<Products> product=[];
  // @override
  // void initState() {
  //   super.initState();
  //   // postData();
  // }

  // String uri = Utilities.url;
  //
  // postData() async {
  //   var response = await http.post(Uri.parse('$uri/api/orders/check'), body: {
  //     "price": widget.product.price.toString(),
  //     "title": widget.product.title,
  //     "image": widget.product.image,
  //     "id": widget.product.id.toString()
  //
  //     // widget.product
  //   });
  //   var response1 =
  //       await http.get(Uri.parse('$uri/api/orders'));
  //   print("cartpost " + response.body);
  //   print("cart " + response1.body);
  //   print("da nhanaa");
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          print("da nhan");
          Cart cart = Cart();
          cart.addProductsToCart(widget.product);
          // postData();
          // print("cart"+cart
          //     .getCart()
          //     .length
          //     .toString());
          Fluttertoast.showToast(
              msg: "Add to cart",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        },
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: const MaterialStatePropertyAll(Colors.green),
        ),
        child: const Text(
          "Add to cart",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
//
// import 'package:mongo_dart/mongo_dart.dart';
//
// void main() async {
//   final db = await Db.create('mongodb://localhost:27017/testdb');
//   await db.open();
//   final userCollection = db.collection('User');
//   final checkoutCollection = db.collection('Checkout');
//   final userDocument = await userCollection.findOne({'username': 'user1'});
//   final checkoutDocument = {
//     'username': userDocument['username'],
//     'password': userDocument['password']
//   };
//   await checkoutCollection.insert(checkoutDocument);
//   await db.close();
// }