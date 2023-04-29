class User {
  // String? id;
   String eMail;
   String password;
  String? id;

  User({required this.eMail, required this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = this.eMail;
    data['password'] = this.password;
    return data;
    //
    // return {
    //   'email': eMail,
    //   'password': password
    //   // 'title': title,
    //   // 'desc': description,
    //   // 'img': image,
    //   // 'price': price,
    //   // '_id': id,
    // };
  }
}
