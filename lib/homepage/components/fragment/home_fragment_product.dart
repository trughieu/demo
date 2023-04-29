import 'dart:convert';

import 'package:demo/model/products.dart';
import 'package:demo/model/utilities.dart';
import 'package:flutter/material.dart%20';
import 'package:http/http.dart' as http;

import '../../../detail/productpage.dart';

class ProductPopular extends StatefulWidget {
  const ProductPopular({Key? key}) : super(key: key);

  @override
  State<ProductPopular> createState() => _ProductPopularState();
}

class _ProductPopularState extends State<ProductPopular> {
  String uri = Utilities.url;
  List<Products> products = [];

  void getProduct() async {
    final response =
        await http.get(Uri.parse('$uri/api/foods'));
    if (response.statusCode == 200) {
      print("asss" + response.body);
      final body = jsonDecode(response.body);
      var food = body['food'];
      for (var p in food) {
        setState(() {
          products.add(Products.fromJson(p as Map<String, dynamic>));
        });
        for (int i = 0; i < products.length; i++) {
          products[i].img =
              Image.network('$uri/${products[i].image}');

          print(products[i].image +
              ' http://172.16.32.55:8000/${products[i].image}');
          setState(() {

          });
        }
      }
    }
  }

  // const ProductPopular({Key? key}) : super(key: key);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    // var productsAPI = Utilities().getProducts();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: const [
              Expanded(
                  child: Text(
                'Popular Products',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              )),
              Text(
                'See more',
                style: TextStyle(fontSize: 16, color: Colors.lightGreen),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7),
              itemBuilder: (context, index) {
                return ProductItem(
                  product: products[index],
                );
              }),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  Products product;

  ProductItem({super.key, required this.product});

  // const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (product.image != null) {}

    // print(product.toString());
    return GestureDetector(
      onTap: () {
        Utilities.data.add(product);
        Navigator.pushNamed(context, ProductPage.routeName,
            arguments: ProductDetailsArguments(product: product));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image.network('http://172.16.32.55:8000/${product.image}')
          product.image == null ? const CircularProgressIndicator() : product.img!,
          const FittedBox(fit: BoxFit.fill)
          // Image.network(
          //   'http://172.16.32.55:8000/${product.image}',
          //   fit: BoxFit.fill,
          // )
          // Image.asset('/asset/foods/'+product.image)
          ,
          Row(
            children: [
              Expanded(child: Text(product.title)),
              Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.green),
                  child: Text(
                    product.price.toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
