import 'dart:convert';

class Orders {
  String userId;
  List<Map<String, dynamic>> products;

  Orders({
    required this.userId,
    required this.products,
  });

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'products': products
            .map((x) => {
                  'image': x['image'] ?? "",
                  'title': x['title'] ?? "",
                  'price': x['price'] ?? 0.0,
                })
            .toList(),
      };
  String toJson() => json.encode(toMap());

}
