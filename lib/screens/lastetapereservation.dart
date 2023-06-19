import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pfeflutter/models/entreprise.dart';
import 'package:pfeflutter/models/ligne.dart';
import 'package:pfeflutter/models/reservation.dart';
import 'package:http/http.dart' as http;
import 'package:pfeflutter/screens/getdatatry.dart';

class lastofus extends StatefulWidget {
  Reservation res;
  String distance, prixx, testt, identre, station11, station22, tempps;

  lastofus({
    Key? key,
    required this.tempps,
    required this.identre,
    required this.station11,
    required this.station22,
    required this.res,
    required this.distance,
    required this.prixx,
    required this.testt,
  }) : super(key: key);

  @override
  _DataWidgetState createState() => _DataWidgetState();
}

class _DataWidgetState extends State<lastofus> {
  String entreprisename = '';
  String test = 'test';
  List<Entreprise> entre = [];

  Future<List<Entreprise>> getentreprise() async {
    String idintr = widget.identre;
    var url = Uri.parse('http://127.0.0.1:8000/api/entre/$idintr');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      entre = jsonResponse.map((data) => Entreprise.fromJson(data)).toList();
      entreprisename = entre[0].name;
      print(entreprisename);

      return entre;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  DateTime datevoyge = DateTime.now();
  void _showDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2025))
        .then((value) {
      setState(() {
        datevoyge = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String ss11 = widget.station11;
    String ss22 = widget.station22;
    Reservation resss = widget.res;
    String des = widget.distance;
    String pri = widget.prixx;
    getentreprise();

    @override
    TextEditingController datee = TextEditingController();
    return MaterialApp(
        home: FutureBuilder<List<Entreprise>>(
            future: getentreprise(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Scaffold(
                  body: Container(
                      child: Stack(
                    children: [
                      Positioned(
                        top: 50,
                        left: 30,
                        child: Container(
                            width: 100,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (widget.testt == "0") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => trtdata(
                                        station11: ss11,
                                        station22: ss22,
                                        test: '0',
                                      ),
                                    ),
                                  );
                                  print('Button pressed');
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => trtdata(
                                        station11: ss11,
                                        station22: ss22,
                                        test: widget.testt,
                                      ),
                                    ),
                                  );
                                  print('Button pressed');
                                }
                              },
                              icon: Icon(Icons
                                  .arrow_back), // Replace with your desired icon
                              label: Text('back'),
                              // Replace with your desired label
                            )),
                      ),
                      Positioned(
                        top: 100,
                        left: 15,
                        right: 15,
                        child: Center(
                          child: Container(
                            child: Text(
                              'Voyage disponible De $ss11 A $ss22 ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black,
                                  fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 200,
                        left: 2,
                        right: 2,
                        child: Center(
                          child: DataTable(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.4),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                            ),
                            columnSpacing: 20,
                            columns: const [
                              DataColumn(
                                  label: Text(
                                    'Temps',
                                    style: TextStyle(
                                        fontSize: 21,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none),
                                  ),
                                  numeric: false),
                              DataColumn(
                                  label: Text(
                                    'prix',
                                    style: TextStyle(
                                        fontSize: 21,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none),
                                  ),
                                  numeric: true),
                              DataColumn(
                                label: Text(
                                  'distance',
                                  style: TextStyle(
                                      fontSize: 21,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                              DataColumn(
                                  label: Text(
                                'entreprise',
                                style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none),
                              )),
                            ],
                            rows: [
                              DataRow(cells: [
                                DataCell(Text(
                                  widget.tempps,
                                  style: TextStyle(fontSize: 20),
                                )),
                                DataCell(Text(
                                  widget.prixx,
                                  style: TextStyle(fontSize: 20),
                                )),
                                DataCell(Text(
                                  widget.distance,
                                  style: TextStyle(fontSize: 20),
                                )),
                                DataCell(Text(
                                  entreprisename,
                                  style: TextStyle(fontSize: 20),
                                )),
                              ]),

                              // Add more rows as needed
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 300,
                        left: 15,
                        right: 15,
                        child: Center(
                            child: ElevatedButton(
                          onPressed: () {
                            _showDate();
                          },
                          child: Text(' date'),
                        )),
                      ),

                      /* Positioned(
            top: 300,
            left: 15,
            right: 15,
            child: Center(
              child: TextField(
                controller: datee,
                onTap: () async {
                  DateTime? pickdate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025));
                },
              ),
            ),
          ),*/
                      Positioned(
                        top: 400,
                        left: 15,
                        right: 15,
                        child: Center(
                          child: Text(datevoyge.toString()),
                        ),
                      ),
                    ],
                  )),
                );
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}
