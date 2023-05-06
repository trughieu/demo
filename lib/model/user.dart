import 'dart:convert';

class User {
  // String? id;
  String eMail;
  String password;
  String id;

  User({required this.eMail, required this.password,required this.id});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = this.eMail;
    data['password'] = this.password;
    return data;
  }
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      eMail: map['email'] ?? '',
      password: map['password'] ?? ''
    );
  }
  String Json() => json.encode(toJson());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? email,
    String? password,
    // String? token,
  }) {
    return User(
        id: id ?? this.id,
        eMail: email ?? this.eMail,
        password: password ?? this.password,
        );
  }
}
