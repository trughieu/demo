import 'dart:convert';

import 'package:demo/model/notification.dart';
import 'package:demo/model/utilities.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'list_tile_notification.dart';

class NotificationDetail extends StatefulWidget {
  const NotificationDetail({Key? key}) : super(key: key);

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  List<NotificationModel> notifications = [];
  String url = Utilities.url;

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    // Gọi API để lấy dữ liệu và gán cho biến notificationData
    final response = await http.get(Uri.parse('$url/api/notification'));
    if (response.statusCode == 200) {
      print(response.body);
      final data = jsonDecode(response.body);
      var noti=data['notification'];
      for (var p in noti) {
        setState(() {
          notifications.add(NotificationModel.fromJson(p as Map<String, dynamic>));
        });
      }
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return notifications != null // check if notifications is not null
        ? Expanded(
      child: ListView.builder(
          itemCount: notifications.length, // add itemCount parameter
          itemBuilder: (context, index) {
            return ListTileNotification(
              notificationModel: notifications[index],
            );
          }),
    )
        : const Center(
      child:
      CircularProgressIndicator(), // show progress indicator while notifications is null
    );
  }
}