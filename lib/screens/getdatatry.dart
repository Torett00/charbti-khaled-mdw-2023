import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pfeflutter/models/entreprise.dart';
import 'package:pfeflutter/models/ligne.dart';
import 'package:pfeflutter/models/reservation.dart';
import 'package:pfeflutter/models/voyage.dart';
import 'package:http/http.dart' as http;
import 'package:pfeflutter/screens/fromTo.dart';
import 'package:pfeflutter/screens/lastetapereservation.dart';

class trtdata extends StatefulWidget {
  String station11, station22;

  trtdata({
    Key? key,
    required this.station11,
    required this.station22,
  }) : super(key: key);

  @override
  _DataWidgetState createState() => _DataWidgetState();
}

class _DataWidgetState extends State<trtdata> {
  List<Ligne> data = [];
  List<Ligne> dataligne = [];
  List<Voyage> datavoyage = [];

  List<Reservation> reservation = [];
  List<Reservation> res = [];
  String distance = '';
  String prixx = '';

  List<int> idvoyagee = [];
  List<Entreprise> entreprise = [];
  List<Entreprise> entr = [];

  Future<Ligne> fetchzData() async {
    var url = Uri.parse('http://127.0.0.1:8000/api/getallligne');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      data = jsonResponse.map((data) => Ligne.fromJson(data)).toList();
      List<Ligne> longFruits = data
          .where((fruit) =>
              fruit.arrive == widget.station11 &&
              fruit.depart == widget.station22)
          .toList();

      return longFruits[0];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Reservation>> getvoyage() async {
    Ligne ix = await fetchzData();
    int idd = ix.id;
    distance = ix.distance;
    prixx = ix.prix;

    var url = Uri.parse('http://127.0.0.1:8000/api/voyage/$idd');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      datavoyage = jsonResponse.map((data) => Voyage.fromJson(data)).toList();
      List<Voyage> hhh = datavoyage;
      datavoyage.forEach((element) {
        idvoyagee.add(element.id);
      });
      for (int el in idvoyagee) {
        var url = Uri.parse('http://127.0.0.1:8000/api/getrall/$el');
        final response = await http.get(url);
        if (response.statusCode == 200) {
          List jsonResponse = json.decode(response.body);
          res = jsonResponse.map((data) => Reservation.fromJson(data)).toList();
          reservation.addAll(res);
        }
      }
      return reservation;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    String ss11 = widget.station11;
    String ss22 = widget.station22;

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
                        builder: (context) => Fromto(),
                      ),
                    );
                    print('Button pressed');
                  },
                  icon: Icon(Icons.home), // Replace with your desired icon
                  label: Text('Home'),
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
                  'Reservation disponible De ${ss11} A ${ss22} ',
                  style: TextStyle(
                      fontFamily: AutofillHints.creditCardExpirationDay,
                      color: Colors.black,
                      fontSize: 25),
                ),
              ),
            ),
          ),
          Positioned(
            top: 150,
            left: 20,
            right: 20,
            child: Container(
              child: FutureBuilder<List<Reservation>>(
                future: getvoyage(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: DataTable(
                        border: TableBorder.all(width: 1),
                        columnSpacing: 30,
                        columns: const [
                          DataColumn(label: Text('depart'), numeric: false),
                          DataColumn(label: Text('arrive'), numeric: false),
                          DataColumn(label: Text('distance'), numeric: true),
                          DataColumn(
                            label: Text('prix'),
                          ),
                          DataColumn(label: Text('reserve')),
                        ],
                        rows: List.generate(
                          snapshot.data!.length,
                          (index) {
                            var data = snapshot.data![index];
                            return DataRow(cells: [
                              DataCell(
                                Text(ss11.toString()),
                              ),
                              DataCell(
                                Text(ss22.toString()),
                              ),
                              DataCell(
                                Text(distance),
                              ),
                              DataCell(
                                Text(prixx),
                              ),
                              DataCell(ElevatedButton(
                                onPressed: () {
                                  // Add your button click logic here

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => lastofus(
                                        station11: ss11.toString(),
                                        station22: ss22.toString(),
                                        res: data,
                                        distance: distance,
                                        prixx: prixx,
                                      ),
                                    ),
                                  );
                                },
                                child: Text('Pickdate'),
                              ))
                            ]);
                          },
                        ).toList(),
                        showBottomBorder: true,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  // By default show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),

          /*Positioned(
            top: 300,
            left: 100,
            right: 100,
            child: Center(
              child: reservation != null
                  ? Container(
                      width: 200,
                      height: 200,
                      color: Colors.blue,
                      child: Text('Content inside the container'),
                    )
                  : Container(
                      child: Text('Content inside the container'),
                    ), // Empty container when data is null
            ),
          ),*/
        ]),
      ),
    );
  }
}
