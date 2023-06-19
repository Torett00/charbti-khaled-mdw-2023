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
  String station11, station22, test;

  trtdata({
    Key? key,
    required this.station11,
    required this.station22,
    required this.test,
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
  String distancee = '';
  String prixx = '';

  List<int> idvoyagee = [];
  List<Entreprise> entreprise = [];
  List<Entreprise> entr = [];
  List<String> temps = [];
  List<String> tempslast = [];
  List<int> entrepr = [];
  List<String> entrenames = [];
  List<Entreprise> testentr = [];
  List<String> priiix = [];
  List<String> entreprisename = [];
  List<String> tempss = [];
  Future<List<Ligne>> fetchzData() async {
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

      return longFruits;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Voyage>> getvoyageee(String id) async {
    var url = Uri.parse('http://127.0.0.1:8000/api/voyage/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      datavoyage = jsonResponse.map((data) => Voyage.fromJson(data)).toList();
      List<Voyage> hhh = datavoyage;
      return hhh;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<Entreprise> getentreprise(String id) async {
    var url = Uri.parse('http://127.0.0.1:8000/api/entre/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      testentr = jsonResponse.map((data) => Entreprise.fromJson(data)).toList();
      return testentr[0];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Reservation>> getvoyagee() async {
    List<Ligne> ix = await fetchzData();

    List<Reservation> lastreservation = [];
    distancee = ix[0].distance;
    var v = 0;
    for (var i = 0; i < ix.length; i++) {
      List<Voyage> voyag = await getvoyageee(ix[i].id.toString());
      List<Reservation> reservation = [];

      for (var element in voyag) {
        try {
          var url =
              Uri.parse('http://127.0.0.1:8000/api/getrall/${element.id}');
          final response = await http.get(url);
          String prix = ix[i].prix;
          if (response.statusCode == 200) {
            List jsonResponse = json.decode(response.body);
            List<Reservation> res =
                jsonResponse.map((data) => Reservation.fromJson(data)).toList();
            tempss.add(element.temps.toString());

            String idres = res[0].entrepriseId.toString();
            Entreprise entree = await getentreprise(idres);
            entreprisename.add(entree.name);
            priiix.add(prix);
            print(ix[i].prix);
            reservation.addAll(res);

            v++;
          }
        } catch (e) {
          // Handle error case for failed network request or unexpected response
          print('Error: $e');
        }
      }

      lastreservation.addAll(reservation);
    }

    return lastreservation;
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
            left: 30,
            child: Container(
                width: 70,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (widget.test == '0') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Fromto(
                            test: '0',
                          ),
                        ),
                      );
                      print('Button pressed');
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Fromto(
                            test: widget.test,
                          ),
                        ),
                      );
                      print('Button pressed');
                    }
                  },
                  icon:
                      Icon(Icons.arrow_back), // Replace with your desired icon
                  label: Text(''),
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
                  'Voyages disponible De ${ss11} A ${ss22} ',
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
            left: 0,
            right: 0,
            child: Container(
              child: FutureBuilder<List<Reservation>>(
                future: getvoyagee(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
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
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none),
                              ),
                              numeric: false),
                          DataColumn(
                              label: Text(
                                'prix',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none),
                              ),
                              numeric: false),
                          DataColumn(
                              label: Text(
                                'Entreprise',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none),
                              ),
                              numeric: true),
                          DataColumn(
                              label: Text(
                            'Action',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none),
                          )),
                        ],
                        rows: List.generate(
                          snapshot.data!.length,
                          (index) {
                            var data = snapshot.data![index];
                            return DataRow(cells: [
                              DataCell(
                                Text(
                                  tempss[index],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              DataCell(
                                Text(
                                  priiix[index],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              DataCell(
                                Text(
                                  entreprisename[index],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              DataCell(ElevatedButton(
                                onPressed: () {
                                  // Add your button click logic here
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => lastofus(
                                        tempps: tempss[index],
                                        identre: data.entrepriseId.toString(),
                                        station11: ss11.toString(),
                                        station22: ss22.toString(),
                                        res: data,
                                        distance: distancee,
                                        prixx: priiix[index],
                                        testt: widget.test,
                                      ),
                                    ),
                                  );
                                },
                                child: Text('Reserve'),
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
