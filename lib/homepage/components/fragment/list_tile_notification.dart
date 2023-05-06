import 'package:flutter/material.dart';

import '../../../model/notification.dart';

class ListTileNotification extends StatelessWidget {
  final NotificationModel notificationModel;

  const ListTileNotification({
    Key? key,
    required this.notificationModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        subtitle: Text(notificationModel.body),
        tileColor: Colors.white,
      ),
    );
  }
}
