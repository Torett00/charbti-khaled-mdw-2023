import 'package:flutter/material.dart';
import 'package:pfeflutter/constant.dart';
import 'package:pfeflutter/models/api_response.dart';

import 'package:pfeflutter/models/user3.dart';
import 'package:pfeflutter/screens/employe.dart';

import 'package:pfeflutter/screens/loading.dart';
import 'package:pfeflutter/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homee.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();
  bool loading = false;
  void _LoginUser() async {
    ApiResponse responsee = await login(txtEmail.text, txtpassword.text);
    if (1 == 1) {
      print(responsee.data.toString());
      _saveAndRedirectToHome(responsee.data as User3);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${responsee.error}')));
    }
  }

  void _saveAndRedirectToHome(User3 user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token);
    await pref.setInt('userId', user.user.id);
    String iduserr = user.user.id.toString();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Employerdash(iduser: iduserr)),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          top: 50,
          left: 10,
          child: Container(
              width: 100,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                  print('Button pressed');
                },
                icon: Icon(Icons.arrow_back), // Replace with your desired icon
                label: Text('Home'),
                // Replace with your desired label
              )),
        ),
        Positioned(
          child: Form(
            key: formkey,
            child: ListView(
              padding: EdgeInsets.all(32),
              children: [
                Column(
                  children: [
                    Image.asset(
                      '/logo2.png',
                      width: 130,
                    ),
                  ],
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: txtEmail,
                  validator: (val) =>
                      val!.isEmpty ? 'invalid email address' : null,
                  decoration: InputDecoration(
                      labelText: 'email',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    obscureText: true,
                    controller: txtpassword,
                    validator: (val) =>
                        val!.isEmpty ? 'required at least 6 chars ' : null,
                    decoration: InputDecoration(
                        labelText: 'password',
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black)))),
                SizedBox(
                  height: 30,
                ),
                loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : kbutton('Se connecter', () {
                        if (formkey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                            _LoginUser();
                          });
                        }
                      }),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
