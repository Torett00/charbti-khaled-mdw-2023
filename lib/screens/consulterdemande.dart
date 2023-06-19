import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:pfeflutter/models/conji.dart';
import 'package:pfeflutter/models/conji2.dart';
import 'package:pfeflutter/screens/conjii.dart';
import 'package:pfeflutter/screens/employe.dart';

class Demande extends StatefulWidget {
  String iduser;
  String entrename;
  String email;
  Demande({
    Key? key,
    required this.iduser,
    required this.entrename,
    required this.email,
  }) : super(key: key);

  @override
  State<Demande> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Demande> {
  Future<List<Conji2>> fetchzData(String iddu) async {
    var url = Uri.parse('http://127.0.0.1:8000/api/getconjiavecid/$iddu');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      dataa = jsonResponse.map((data) => Conji2.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
    return dataa;
  }

  List<Conji2> dataa = [];

  @override
  Widget build(BuildContext context) {
    String idd = widget.iduser;
    String entre = widget.entrename;
    String email = widget.email;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<List<Conji2>>(
        future: fetchzData(idd),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Container(
                child: Stack(children: [
                  Positioned(
                    top: 10,
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
                    top: 150,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        ' demandes Congé ',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    child: Container(
                        width: 130,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Employerdash(
                                  iduser: idd,
                                ),
                              ),
                            );
                            print('Button pressed');
                          },
                          icon: Icon(
                              Icons.home), // Replace with your desired icon
                          label: Text('dashboord'),
                          // Replace with your desired label
                        )),
                  ),
                  Positioned(
                    top: 210,
                    left: 0,
                    right: 10,
                    child: Container(
                      child: DataTable(
                        border: TableBorder.all(width: 1),
                        columnSpacing: 25,
                        columns: const [
                          DataColumn(label: Text('name'), numeric: false),
                          DataColumn(label: Text('reson'), numeric: false),
                          DataColumn(label: Text('nbrjr'), numeric: true),
                          DataColumn(
                            label: Text('datecongé'),
                          ),
                          DataColumn(label: Text('état')),
                        ],
                        rows: List.generate(
                          snapshot.data!.length,
                          (index) {
                            var data = snapshot.data![index];
                            return DataRow(cells: [
                              DataCell(
                                Text(data.name.toString()),
                              ),
                              DataCell(
                                Text(data.reason.toString()),
                              ),
                              DataCell(
                                Text(data.nbrjr.toString()),
                              ),
                              DataCell(
                                Text(data.dateconji.toString()),
                              ),
                              DataCell(
                                Text(data.etat.toString()),
                              ),
                            ]);
                          },
                        ).toList(),
                        showBottomBorder: true,
                      ),
                    ),
                  ),
                ]),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
