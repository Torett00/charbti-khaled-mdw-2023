import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'homee.dart';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool loading = false;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController passwordconfiramationcontroller =
      TextEditingController();

  void _Registeruser() async {
    ApiResponse response = await register(
        namecontroller.text, emailcontroller.text, passwordcontroller.text);
    if (1 == 1) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          centerTitle: true,
        ),
        body: Form(
          key: formkey,
          child: ListView(
            padding: EdgeInsets.all(32),
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: namecontroller,
                validator: (val) => val!.isEmpty ? 'invalid name' : null,
                decoration: InputDecoration(
                    labelText: 'name',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailcontroller,
                validator: (val) =>
                    val!.isEmpty ? 'invalid email address' : null,
                decoration: InputDecoration(
                    labelText: 'email',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  obscureText: true,
                  controller: passwordcontroller,
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
              TextFormField(
                  obscureText: true,
                  controller: passwordconfiramationcontroller,
                  validator: (val) =>
                      val!.isEmpty ? 'required at least 6 chars ' : null,
                  decoration: InputDecoration(
                      labelText: 'password confiramtion',
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
                  : kbutton('Register', () {
                      if (formkey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                          _Registeruser();
                        });
                      }
                    }),
              SizedBox(
                height: 10,
              ),
              kLoginRegisterHint('u have a acounnt', 'Login', () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false);
              })
            ],
          ),
        ));
  }
}
