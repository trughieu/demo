import 'package:flutter/material.dart ';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../homepage.dart';
import '../../model/user.dart';
import '../../model/userProvider.dart';
import '../../model/utilities.dart';
import '../../signup/signup_page.dart';

class SignInForm extends StatefulWidget {
  SignInForm({super.key});

  // const SignInForm({Key? key}) : super(key: key);
  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  bool _value = false;
  var result;

  // ignore: prefer_typing_uninitialized_variables
  late SharedPreferences prefs;
  final username = TextEditingController();
  final password = TextEditingController();

  late FToast fToast;
  String uri = Utilities.url;

  Future<http.Response> postRequest(String email, String pass) async {
    final response = await http.post(
      Uri.parse('$uri/api/users/signin'),
      body: {
        'email': email,
        'password': pass,
      },
    );
    print(email);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Provider.of<UserProvider>(context, listen: false).setUser(response.body);
      print(response.body);
      Navigator.pushNamed(context, HomePage.routeName);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login success')));
    } else {
      print('$uri/api/users/signin');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login faild')));
    }
    print(response.body);
    return response;
  }

  // Future<void> submit() async {
  //   final response = await postRequest(username.text, password.text);
  //   print(response.body);
  // }

  // final response = await http.post(Uri.parse("http://172.16.32.55:8000/api/users/signup"));
  // if (response.statusCode == 200) {
  //   print(response.body);
  //   final body = jsonDecode(response.body);
  //   var user = body['user'];
  //   for (var o in user) {
  //     setState(() {
  //       userApi.add(User.fromMap(o as Map<String, dynamic>));
  //     });
  //     for (int i = 0; i < userApi.length; i++) {
  //       usernameApi = userApi[i].eMail;
  //       passwordApi = userApi[i].password;
  //       print(usernameApi);
  //       print(passwordApi);
  //     }
  //   }
  // }
  // else{
  //   print("khong co du lieu ");
  // }

  //
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _getData();
    // getAccount();
  }

  _getData() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString('username')!.isNotEmpty) {
      username.text = prefs.getString('username')!;
      password.text = prefs.getString('password')!;
      _value = prefs.getBool('check')!;
    }
  }

  // _getData() async {
  //   prefs=await SharedPreferences.getInstance();
  //   if(prefs.)
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Food Now",
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Sign in with your email and password \nor continue with social media",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      validator: (value) {
                        return Utilities.validatePassword(value!);
                      },
                      onSaved: (_value) {
                        setState(() {
                          username.text = _value!;
                        });
                      },
                      controller: username,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Username",
                          prefixIcon: Icon(Icons.mail_outline)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: password,
                      validator: (value) {
                        return Utilities.validatePassword(value!);
                      },
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock_outline_rounded)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          postRequest(username.text, password.text);
                          // print(usernameApi);
                          // print(passwordApi);
                          // if (_value) {
                          //   prefs = await SharedPreferences.getInstance();
                          //   prefs.setString('username', username.text);
                          //   prefs.setString('password', username.text);
                          //   prefs.setBool('check', _value);
                          // } else {
                          //   prefs.remove('check');
                          // }
                          // if (username.text == usernameApi &&
                          //     password.text == passwordApi) {
                          //   Navigator.pushNamed(context, HomePage.routeName);
                          // }
                          // submit();
                          // goi nguoc lai navigator.pop
                        },
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.green),
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
                      height: 5,
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
                                color: Color(0xFFF5F6F9),
                                shape: BoxShape.circle),
                            child:
                                SvgPicture.asset("asset/icons/facebook-2.svg"),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xFFF5F6F9),
                                shape: BoxShape.circle),
                            child: SvgPicture.asset("asset/icons/google.svg"),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xFFF5F6F9),
                                shape: BoxShape.circle),
                            child: SvgPicture.asset("asset/icons/twitter.svg"),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account ?",
                          style: TextStyle(color: Colors.green, fontSize: 14),
                        ),
                        GestureDetector(
                            onTap: () async {
                              // Navigator.pushNamed(
                              //     context, SignUpPage.routeName);
                              final result = await Navigator.pushNamed(
                                  context, SignUpPage.routeName);
                              User? user = result as User?;
                              username.text = user!.eMail;
                              password.text = user!.password;
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 14),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    return const Placeholder();
  }
}
