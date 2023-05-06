import 'dart:convert';

class NotificationModel {
  final String userId, total, body;

  NotificationModel(
      {required this.userId, required this.total, required this.body});

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'userId': userId,
      'body': body,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      total: map['total'],
      body: map['body'],
      userId: map['userId'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(Map<String, dynamic> item) {
    return NotificationModel(
        userId:item['userId'] ,
        total: item['total'],
        body: item['body']);
  }
}
