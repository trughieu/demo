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

  void _changePassword() async {
    String email = _email.text;
    String newPassword = _password.text;
    String confirmPassword = _conform.text;

    if (newPassword != confirmPassword) {
      // Kiểm tra mật khẩu mới và mật khẩu xác nhận có khớp hay không
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Lỗi'),
            content: Text('Mật khẩu mới và mật khẩu xác nhận không khớp.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Gửi request đổi mật khẩu đến server
    var url = Uri.parse('$uri/api/users/changePassword');
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      'email': email,
      'newPassword': newPassword,
    });

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Đổi mật khẩu thành công
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Thành công'),
            content: Text('Mật khẩu đã được thay đổi thành công.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Xử lý lỗi khi đổi mật khẩu
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Lỗi'),
            content: Text('Đã xảy ra lỗi khi đổi mật khẩu.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
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
                _changePassword();
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
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Re-enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_outline)),
      onSaved: (valueconfirm) {
        setState(() {
          _conform.text = valueconfirm!;
        });
      },
    );
  }

  TextFormField passwordTextFormField() {
    return TextFormField(
      controller: _password,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
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
