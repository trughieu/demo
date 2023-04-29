import 'package:demo/model/products.dart';
import 'package:flutter/material.dart';

import 'addtocart.dart';

class Body extends StatelessWidget {
  // const Body({Key? key}) : super(key: key);

  Products product;
  Body ({super.key, required this.product});
  
  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: product.img
            // Image.network('http://172.16.32.55:8000/${product.image}')
          ),
          const SizedBox(height: 20,),
          Expanded(flex: 1,child: Text("Description: ${product.description}"),),
          AddProductToCart(product: product,)
        ],
      ),
    );
  }
}
