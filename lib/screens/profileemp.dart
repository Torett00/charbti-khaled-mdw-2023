import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pfeflutter/models/employe.dart';
import 'package:http/http.dart' as http;
import 'package:pfeflutter/screens/employe.dart';

class Profile extends StatefulWidget {
  Employe em;
  Profile({
    Key? key,
    required this.em,
  }) : super(key: key);

  @override
  State<Profile> createState() => _MyWidgetState();
}

bool isvisible = true;
String submit = "0";

class _MyWidgetState extends State<Profile> {
  @override
  void initState() {
    super.initState();

    // Start a timer to hide the child widget after 5 seconds
    Timer(Duration(seconds: 5), () {
      setState(() {
        isvisible = false;
      });
    });
  }

  void updateData(
      String nom, String tel, String add, String pos, String sal) async {
    String idd = widget.em.userId.toString();
    print(idd);
    var url = Uri.parse('http://127.0.0.1:8000/api/putemploye/$idd');

    try {
      var response = await http.put(
        url,
        body: {
          'name': nom,
          'telephone': tel,
          'adresse': add,
          'poste': pos,
          'salaire': sal,
        },
      );
      if (response.statusCode == 200) {
        print('Data updated successfully');
        submit = '1';

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(em: widget.em),
          ),
        );
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController txtname = TextEditingController();
  TextEditingController txtaddress = TextEditingController();
  TextEditingController txttelphone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Employe emp = widget.em;
    String iduser = emp.userId.toString();
    String name = emp.name.toString();
    String address = emp.adresse.toString();
    String tele = emp.telephone.toString();
    String saliree = emp.salaire.toString();
    String rol = emp.poste.toString();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 50,
            child: Container(
                width: 100,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Employerdash(iduser: iduser),
                      ),
                    );
                    print('Button pressed');
                  },
                  icon: Icon(Icons.home), // Replace with your desired icon
                  label: Text('Home'),
                  // Replace with your desired label
                )),
          ),
          if (submit == '1')
            Positioned(
              top: 5,
              left: 90,
              right: 50,
              child: Container(
                child: Center(
                  child: Text(
                    'Data updated successfully',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            top: 100,
            left: 50,
            right: 50,
            child: Text(
              'Modifer Profile:',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 50,
            right: 50,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Positioned(
                    top: 220,
                    left: 0,
                    right: 0,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: '$name'),
                      controller: txtname,
                      validator: (val) =>
                          val!.isEmpty ? 'required at least 6 chars ' : null,
                    ),
                  ),
                  Positioned(
                    top: 220,
                    left: 40,
                    right: 0,
                    child: Text('Name'),
                  ),
                  Positioned(
                    top: 250,
                    left: 0,
                    right: 0,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: '$tele'),
                      controller: txttelphone,
                      validator: (val) =>
                          val!.isEmpty ? 'required at least 6 chars ' : null,
                    ),
                  ),
                  Positioned(
                    top: 250,
                    left: 40,
                    right: 0,
                    child: Text('Telephone'),
                  ),
                  Positioned(
                    top: 280,
                    left: 0,
                    right: 0,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: '$address'),
                      controller: txtaddress,
                      validator: (val) =>
                          val!.isEmpty ? 'required at least 6 chars ' : null,
                    ),
                  ),
                  Positioned(
                    top: 280,
                    left: 40,
                    right: 0,
                    child: Text('Addresse'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        updateData(txtname.text, txttelphone.text,
                            txtaddress.text, saliree, rol);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 500,
            left: 50,
            right: 50,
            child: Text(
              'Details:',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Positioned(
            top: 550,
            left: 50,
            right: 50,
            child: Container(
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
              width: 300,
              height: 180,
              child: Stack(children: [
                Positioned(
                  top: 20,
                  left: 10,
                  child: Text(
                    'Salaire:$saliree',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 10,
                  child: Text(
                    'Postee:$rol',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
