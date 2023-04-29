import 'package:flutter/material.dart%20';

import '../../homeheader.dart';
import '../../menuheader.dart';
import '../../model/utilities.dart';
import 'fragment/account_detail.dart';
import 'fragment/home_fragment.dart';
import 'fragment/favorit_fragment.dart';
import 'fragment/notification_detail.dart';

class Body extends StatefulWidget {
  // const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var selectIndex = 0;
  var flag = true;

  @override
  Widget build(BuildContext context) {

    List<Widget> screen = [
      HomeDetail(),
      FavoriteDetail(Utilities.data),
      NotificationDetail(),
      AccountDetail()
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: flag ? HomeHeader() : MenuHeader(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectIndex,
        onTap: (index) {
          setState(() {
            selectIndex = index;
            if (selectIndex != 3) {
              flag = true;
            } else {
              flag = false;
            }
          });
        },
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,),
            screen[selectIndex]
          ],
        ),
      ),
    );
  }
}
