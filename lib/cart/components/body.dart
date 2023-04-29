import 'dart:convert';
import 'package:demo/model/oder.dart';
import 'package:demo/model/user.dart';
import 'package:demo/model/utilities.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  // const Body({Key? key}) : super(key: key);
   late User user;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String uri = Utilities.url;

  // List<Orders> cartdetail=Cart().getCart();
  // List<Oders> cartdetail=[];
  double sum = 0.0;
  List<Orders> orders = [];
  Orders? order;

  void getOder() async {
    final response =
    await http.get(Uri.parse('$uri/api/orders'));
    if (response.statusCode == 200) {
      print("order ${response.body}");
      print(widget.user.eMail);

      final body = jsonDecode(response.body);
      var oder = body['order'];
      for (var o in oder) {
        setState(() {
          orders.add(Orders.fromJson(o as Map<String, dynamic>));
        });
        for (int i = 0; i < orders.length; i++) {
          orders[i].img =
              Image.network('$uri/${orders[i].image}');
          print(
              '${orders[i].image} http://172.16.32.55:8000/${orders[i].image}');
          setState(() {});
        }
      }
    }
  }

  delete() async {
    for (int i = 0; i < orders.length; i++) {
      var response = await http
          .delete(Uri.parse('$uri/api/orders/'));
      print("http://172.16.32.55:8000/api/orders/");
      print("delete ${response.body}");
    }
    print("da nhan delete");
  }

  deleteOrder(int id) async {
    for (int i = 0; i < orders.length; i++) {
      var response = await http
          .delete(Uri.parse('$uri/api/orders/$id'));
      print("http://172.16.32.55:8000/api/orders/$id");
      print("delete ${response.body}");
    }
    print("da nhan delete");
  }

  postCheckout() async {
    var res = await http.post(Uri.parse('$uri/api/checkout'),
        body:
        {
        "id_user": widget.user.eMail,
        });
    print(widget.user.eMail);
  }

  @override
  void initState() {
    super.initState();
    getOder();
    postCheckout();
    // orders.forEach((order){sum=sum+order.price;});
  }

  @override
  Widget build(BuildContext context) {
    orders.forEach((order) {
      sum = sum + order.price;
    });

    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        child: CartItem(
                          orders: orders[index],
                        ),
                        onTap: () {
                          setState(() {
                            orders[index].id;
                            deleteOrder(orders[index].id);
                            orders.removeAt(index);
                            sum = 0.0;
                            // print("abc "+deleteOrder( orders[index].id));

                          });
                        },
                      ),
                      Divider()
                    ],
                  );
                }),
          ),
          Row(children: [
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: const BorderSide(color: Colors.green))),
                  backgroundColor: const MaterialStatePropertyAll(Colors.white),
                  side: const MaterialStatePropertyAll(
                      BorderSide(color: Colors.green)),
                  iconSize: const MaterialStatePropertyAll(
                    50,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Sum:${sum}",
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0))),
                  side: const MaterialStatePropertyAll(
                      BorderSide(color: Colors.green)),
                ),

                // onPressed: (
                //
                //   )
                //
                onPressed: () {
                  setState(() {
                    delete();
                    orders.clear();
                  });
                  // orders.clear();
                  // delete();
                },
                child: Text("Check out".toUpperCase(),
                    style: const TextStyle(fontSize: 14)),
              ),
            )
          ],)
          // CheckOutCart(
          //   sum: sum,
          //   orders: orders,
          // )
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  // const CartItem({Key? key}) : super(key: key);
  Orders orders;

  CartItem({required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F5F5),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          SizedBox(width: 100, height: 100, child: orders.img),
          Expanded(child: Text(orders.title)),
          Expanded(child: Text(orders.price.toString())),
          Icon(Icons.delete_outline)
        ],
      ),
    );
  }
}
