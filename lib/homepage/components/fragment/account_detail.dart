import 'dart:convert';

import 'package:demo/model/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class AccountDetail extends StatefulWidget {
  // const AccountDetail({Key? key}) : super(key: key);

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _conform = TextEditingController();
  String uri = Utilities.url;

  void updateUserPassword
      (String email, String oldPassword, String newPassword) async {
    String apiUrl = 'https://your-api-url.com/user/updatePassword';
    String authToken = 'your-auth-token';

    Map<String, String> body = {
      'email': email,
      'password': oldPassword,
      'new_password': newPassword,
    };

    var response = await http.post(Uri.parse('$uri/api/users/updatePassword'),
        body: json.encode(body));

    if (response.statusCode == 200) {
      // Cập nhật mật khẩu thành công.
      print(response.body);
    } else {
      print(response.body);
      print("fail");
      // Xử lý lỗi từ máy chủ.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          emailTextFormField(),
          const SizedBox(
            height: 30,
          ),
          passwordTextFormField(),
          const SizedBox(
            height: 30,
          ),
          conformTextFormField(),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                // Navigator.pop(context, email.text);
                // updateUserPassword(mail, oldpass, newpass);
                updateUserPassword(_email.text, _password.text, _conform.text);
                print(_email.text);
                print(_password.text);
                print(_conform.text);
              },
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                backgroundColor: const MaterialStatePropertyAll(Colors.green),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Color(0xFFF5F6F9), shape: BoxShape.circle),
                  child: SvgPicture.asset("asset/icons/facebook-2.svg"),
                ),
                Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: const BoxDecoration(
                      color: Color(0xFFF5F6F9), shape: BoxShape.circle),
                  child: SvgPicture.asset("asset/icons/google.svg"),
                ),
                Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Color(0xFFF5F6F9), shape: BoxShape.circle),
                  child: SvgPicture.asset("asset/icons/twitter.svg"),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  TextFormField emailTextFormField() {
    return TextFormField(
        controller: _email,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "enter your email ",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Icon(Icons.email_outlined)),
        onSaved: (value) {
          setState(() {
            _email.text = value!;
          });
        });
  }

  TextFormField conformTextFormField() {
    return TextFormField(
      controller: _conform,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Re-enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_outline)),
      onSaved: (valueconfirm) {
        setState(() {
          _conform.text = valueconfirm!;
        });
        ;
      },
    );
  }

  TextFormField passwordTextFormField() {
    return TextFormField(
      controller: _password,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_outline)),
      onSaved: (pass) {
        _password.text = pass!;
      },
    );
  }
}
