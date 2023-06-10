import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pfeflutter/models/entreprise.dart';
import 'package:pfeflutter/models/ligne.dart';
import 'package:pfeflutter/models/reservation.dart';
import 'package:http/http.dart' as http;
import 'package:pfeflutter/screens/getdatatry.dart';

class lastofus extends StatefulWidget {
  String station11, station22;
  Reservation res;
  String distance, prixx;

  lastofus({
    Key? key,
    required this.station11,
    required this.station22,
    required this.res,
    required this.distance,
    required this.prixx,
  }) : super(key: key);

  @override
  _DataWidgetState createState() => _DataWidgetState();
}

class _DataWidgetState extends State<lastofus> {
  String entreprisename = '';
  String test = 'test';
  List<Entreprise> entre = [];

  Future<List<Entreprise>> getentreprise() async {
    int idintr = widget.res.id;
    var url = Uri.parse('http://127.0.0.1:8000/api/entre/1');
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
                        child: Container(
                            width: 100,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => trtdata(
                                      station11: ss11,
                                      station22: ss22,
                                    ),
                                  ),
                                );
                                print('Button pressed');
                              },
                              icon: Icon(
                                  Icons.home), // Replace with your desired icon
                              label: Text('Previous'),
                              // Replace with your desired label
                            )),
                      ),
                      Positioned(
                        top: 50,
                        left: 15,
                        right: 15,
                        child: Center(
                          child: Container(
                            child: Text(
                              'Reservation disponible De $ss11 A $ss22 ',
                              style: TextStyle(
                                  fontFamily:
                                      AutofillHints.creditCardExpirationDay,
                                  color: Colors.black,
                                  fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 100,
                        left: 15,
                        right: 15,
                        child: Center(
                          child: DataTable(
                            border: TableBorder.all(width: 1),
                            columnSpacing: 30,
                            columns: const [
                              DataColumn(label: Text('depart'), numeric: false),
                              DataColumn(label: Text('arrive'), numeric: false),
                              DataColumn(
                                  label: Text('distance'), numeric: true),
                              DataColumn(
                                label: Text('prix'),
                              ),
                              DataColumn(label: Text('entreprise')),
                            ],
                            rows: [
                              DataRow(cells: [
                                DataCell(Text(ss11)),
                                DataCell(Text(ss22)),
                                DataCell(Text(des)),
                                DataCell(Text(pri)),
                                DataCell(Text(entreprisename)),
                              ]),

                              // Add more rows as needed
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 200,
                        left: 15,
                        right: 15,
                        child: Center(
                            child: ElevatedButton(
                          onPressed: () {
                            _showDate();
                          },
                          child: Text('choes date'),
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
                        top: 300,
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
