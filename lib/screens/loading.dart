import 'package:flutter/material.dart';
import 'package:pfeflutter/constant.dart';
import 'package:pfeflutter/main.dart';
import 'package:pfeflutter/models/api_response.dart';
import 'package:pfeflutter/services/user_service.dart';
import 'login.dart';
import 'register.dart';
import 'homee.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void _loaduserInfo() async {
    String token = await getToken();
    if (token == '') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Register()),
          (route) => false);
    } else {
      ApiResponse response = await getuserDetail();
      if (response.error == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
      } else if (response.error == unauthorized) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}')));
      }
    }
  }

  @override
  void initState() {
    _loaduserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
