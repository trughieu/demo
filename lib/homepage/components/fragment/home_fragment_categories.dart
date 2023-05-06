import 'dart:convert';

import 'package:demo/model/categories.dart';
import 'package:demo/model/utilities.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriesStore extends StatefulWidget {
  CategoriesStore({Key? key}) : super(key: key);

  @override
  State<CategoriesStore> createState() => _CategoriesStoreState();
}

class _CategoriesStoreState extends State<CategoriesStore> {
  String uri = Utilities.url;
  List<Categories> categories = [];

  void getProduct() async {
    final response = await http.get(Uri.parse('$uri/api/categories'));
    if (response.statusCode == 200) {
      print("cate " + response.body);

      final body = jsonDecode(response.body);
      var category = body['category'];
      for (var cate in category) {
        setState(() {
          categories.add(Categories.fromJson(cate as Map<String, dynamic>));
        });
        for (int i = 0; i < categories.length; i++) {
          categories[i].img =
              Image.network('$uri/${categories[i].image}');

        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    // final categories = Categories.init();
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(
                    child: Text(
                  'Categories',
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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoriesItem(category: categories[index]);
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class CategoriesItem extends StatelessWidget {
  Categories category;

  CategoriesItem({required this.category});

  // const CategoriesItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: 150,
        padding: const EdgeInsets.all(5),
        child:
            category.image == null ? CircularProgressIndicator() : category.img!
        // Image.network('http://172.16.32.55:8000/${category.image}'),
        );
  }
}
