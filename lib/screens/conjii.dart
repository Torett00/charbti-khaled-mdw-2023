import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pfeflutter/constant.dart';
import 'package:pfeflutter/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:pfeflutter/models/conji.dart';
import 'package:pfeflutter/screens/employe.dart';

class Dconji extends StatefulWidget {
  String iduser;
  String ident;
  Dconji({
    Key? key,
    required this.iduser,
    required this.ident,
  }) : super(key: key);

  @override
  State<Dconji> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Dconji> {
  Future<ApiResponse> register(String name, String rea, String nbr, String dat,
      String iduserr, String identreprise) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http
          .post(Uri.parse('http://127.0.0.1:8000/api/conji'), headers: {
        'Accept': 'Application/json'
      }, body: {
        'name': name,
        'reason': rea,
        'nbrjr': nbr,
        'date': dat,
        'user_id': iduserr,
        'etat': '1',
        'entreprise_id': identreprise,
      });
      switch (response.statusCode) {
        case 200:
          apiResponse.data = Conji.fromJson(jsonDecode(response.body));

          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        default:
          apiResponse.error = somthingwentwrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
    }
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => Employerdash(iduser: iduserr)));
    return apiResponse;
  }

  bool loading = false;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController nbrjr = TextEditingController();
  TextEditingController date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String iduser = widget.iduser;
    String idintre = widget.ident;
    return Scaffold(
      body: Container(
        child: Stack(children: [
          Positioned(
            top: 50,
            child: Container(
                width: 100,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Employerdash(
                          iduser: iduser,
                        ),
                      ),
                    );
                    print('Button pressed');
                  },
                  icon: Icon(Icons.home), // Replace with your desired icon
                  label: Text('dashboord'),
                  // Replace with your desired label
                )),
          ),
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Saisir les données',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
          Positioned(
            top: 150,
            left: 30,
            right: 30,
            child: Container(
              width: 380,
              height: 500,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 23, 142, 240),
                      Color.fromARGB(255, 232, 233, 234),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: formkey,
                child: ListView(
                  padding: EdgeInsets.all(32),
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: namecontroller,
                      validator: (val) => val!.isEmpty ? 'invalid name' : null,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'name',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: reason,
                      validator: (val) =>
                          val!.isEmpty ? 'invalid email address' : null,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Reason',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        obscureText: true,
                        controller: nbrjr,
                        validator: (val) =>
                            val!.isEmpty ? 'required at least 6 chars ' : null,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'nombre de jour ',
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.white)))),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        obscureText: true,
                        controller: date,
                        validator: (val) =>
                            val!.isEmpty ? 'required at least 6 chars ' : null,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Date ',
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.white)))),
                    SizedBox(
                      height: 30,
                    ),
                    loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : kbotconji('Demender', () {
                            if (formkey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                                register(namecontroller.text, reason.text,
                                    nbrjr.text, date.text, iduser, idintre);
                              });
                            }
                          }),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
