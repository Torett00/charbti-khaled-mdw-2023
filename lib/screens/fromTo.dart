import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:pfeflutter/screens/employe.dart';

import 'package:pfeflutter/screens/getdatatry.dart';
import 'package:pfeflutter/screens/homee.dart';

import '../constant.dart';

class Fromto extends StatefulWidget {
  String test;
  Fromto({
    Key? key,
    required this.test,
  }) : super(key: key);

  @override
  State<Fromto> createState() => _MyWidgetState();
}

List data = [];
String? _value;
String? _value2;
String? Station1;
String? Station2;
bool loading = false;

class _MyWidgetState extends State<Fromto> {
  getData() async {
    final res = await http.get(Uri.parse('http://127.0.0.1:8000/api/stations'));
    data = jsonDecode(res.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: 30,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Image.asset(
                    '/logo2.png',
                    width: 130,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 50,
              child: Container(
                  width: 100,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (widget.test == '0') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Employerdash(
                              iduser: widget.test,
                            ),
                          ),
                        );
                      }

                      print('Button pressed');
                    },
                    icon: Icon(
                        Icons.arrow_back), // Replace with your desired icon
                    label: Text('Home'),
                    // Replace with your desired label
                  )),
            ),
            Positioned(
              top: 170,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Depart',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 220,
              left: 10,
              right: 10,
              child: DropdownButton(
                items: data.map((e) {
                  return DropdownMenuItem(
                    child: Text(e["station"]),
                    value: e["station"],
                  );
                }).toList(),
                value: _value,
                hint: Text('Select station'),
                onChanged: (v) {
                  _value = v as String;
                  setState(() {
                    Station1 = _value;
                  });
                },
              ),
            ),
            Positioned(
              top: 290,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Arrivée',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
            Positioned(
              top: 340,
              left: 10,
              right: 10,
              child: DropdownButton(
                items: data.map((e) {
                  return DropdownMenuItem(
                    child: Text(e["station"]),
                    value: e["station"],
                  );
                }).toList(),
                value: _value2,
                hint: Text('Select station'),
                onChanged: (v2) {
                  _value2 = v2 as String;
                  setState(() {
                    Station2 = _value2;
                  });
                },
              ),
            ),
            Positioned(
              top: 430,
              left: 100,
              right: 100,
              child: loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : kbutton('Consulter', () {
                      dispose();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => trtdata(
                            station11: Station1.toString(),
                            station22: Station2.toString(),
                            test: widget.test,
                          ),
                        ),
                      );
                    }),
            ),
          ],
        ),
      ),
    );
  }
}
