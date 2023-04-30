import 'package:demo/model/user.dart';
import 'package:demo/model/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart  ';
import 'package:http/http.dart' as http;

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  // const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _conform = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();

  String uri = Utilities.url;

  // void createUser() {
  //   String email = _email.text;
  //   String pass = _conform.text;
  //   User user = User(eMail: email, password: pass);
  //   postAccount(user);
  // }

  postAccount() async {
    var response = await http.post(Uri.parse('$uri/api/users/signup'),
        body: {"email": _email.text, "password": _conform.text});
    print("response body: " + response.body);
  }

  // {
  //   User(eMail: email.text, password: password.text)
  //   // "id": "1",
  //   // "email": "hieu",
  //   // "password": "12345678",
  // });
  //   print(response.body);
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            emalTextFormField(),
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context,
                        User(eMail: _email.text, password: _conform.text,id: ""));
                    User user =
                        User(eMail: _email.text, password: _conform.text,);
                    postAccount();

                    //     id: await FlutterUdid.udid));
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.green)),
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
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.all(10),
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
                ))
          ],
        ),
      ),
    );
  }

  TextFormField emalTextFormField() {
    return TextFormField(
        controller: _email,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter your email",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Icon(Icons.email_outlined)),
        // validator: Utilities.validateEmail,
        onSaved: (value) {
          setState(() {
            _email.text = value!;
          });
        });
  }

  TextFormField passwordTextFormField() {
    return TextFormField(
      key: _passKey,
      controller: _password,
      obscureText: true,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_outline)),
      validator: (passwordKey) {
        return Utilities.validatePassword(passwordKey!);
      },
    );
  }

  TextFormField conformTextFormField() {
    return TextFormField(
      controller: _conform,
      obscureText: true,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Re-enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_outline)),
      validator: (conformPassword) {
        var pass = _passKey.currentState?.value;
        return Utilities.confirmPassword(conformPassword!, pass);
      },
      onSaved: (value) {
        setState(() {
          _conform.text = value!;
        });
      },
    );
  }
}
