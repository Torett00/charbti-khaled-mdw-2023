import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pfeflutter/constant.dart';
import 'package:pfeflutter/models/api_response.dart';
import 'package:pfeflutter/models/pointage.dart';
import 'package:http/http.dart' as http;
import 'package:pfeflutter/screens/employe.dart';
import 'package:pfeflutter/screens/homee.dart';

class pointge extends StatefulWidget {
  String iduser;
  String entrename;
  String email;
  pointge({
    Key? key,
    required this.iduser,
    required this.entrename,
    required this.email,
  }) : super(key: key);

  @override
  State<pointge> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<pointge> {
  String idd = '';
  List<Pointage> pointages = [];
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<List<Pointage>> getpoint() async {
    String id = widget.iduser;
    String idd = id;
    var url = Uri.parse('http://127.0.0.1:8000/api/getpointage/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      pointages = jsonResponse.map((data) => Pointage.fromJson(data)).toList();

      return pointages;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  DateTime datelyoum = DateTime.now();
  void point() {
    String idd = widget.iduser;
    String entre = widget.entrename;
    String emaile = widget.email;
    String id = pointages[0].currentjour.toString();
    int jourlast = int.parse(id);

    String mont = pointages[0].currentmois.toString();
    int monthlast = int.parse(mont);

    if (datelyoum.day > jourlast) {
      String dayss = pointages[0].nombredejour.toString();
      int alldays = int.parse(dayss) + 1;
      dayss = alldays.toString();
      String day = datelyoum.day.toString();
      updateData(dayss, day, mont);
      print('nicee');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => pointge(
                    iduser: idd,
                    entrename: entre,
                    email: emaile,
                  )));
    } else {
      print('no wayy');
    }
  }

  void updateData(String nbrj, String curenjot, String curentmo) async {
    var url = Uri.parse('http://127.0.0.1:8000/api/pointe/1');

    try {
      var response = await http.put(
        url,
        body: {
          'nombredejour': nbrj,
          'currentjour': curenjot,
          'currentmois': curentmo,
        },
      );
      if (response.statusCode == 200) {
        print('Data updated successfully');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  /*Future<ApiResponse> register(
      String nbrj, String curenjot, String curentmo) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http
          .put(Uri.parse('http://127.0.0.1:8000/api/pointe/1'), body: {
        'nombredejour': nbrj,
        'currentjour': curenjot,
        'currentmois': curentmo,
      });

      if (response.statusCode == 200) {
        print('Data updated successfully');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      apiResponse.error = serverError;
    }

    return apiResponse;
  }*/

  @override
  Widget build(BuildContext context) {
    String iddd = widget.iduser;
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
                          iduser: iddd,
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
              top: 100,
              left: 50,
              right: 50,
              child: Text(
                "Pointage ",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Positioned(
            top: 100,
            left: 200,
            child: Container(
                width: 120,
                child: ElevatedButton.icon(
                  onPressed: () {
                    point();
                  },
                  icon: Icon(Icons.home), // Replace with your desired icon
                  label: Text('Pointe'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Set the background color
                    // You can also customize other properties like padding, shape, etc.
                  ),

                  // Replace with your desired label
                )),
          ),
          Positioned(
            top: 200,
            left: 10,
            right: 10,
            child: Container(
              child: FutureBuilder<List<Pointage>>(
                future: getpoint(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: DataTable(
                        border: TableBorder.all(width: 1),
                        columnSpacing: 28,
                        columns: const [
                          DataColumn(
                              label: Text('nombre de jour travallie'),
                              numeric: false),
                          DataColumn(
                              label: Text('dernier jour pointage'),
                              numeric: false),
                        ],
                        rows: List.generate(
                          snapshot.data!.length,
                          (index) {
                            var data = snapshot.data![index];
                            var day = data.currentjour;
                            var month = data.currentmois;
                            return DataRow(cells: [
                              DataCell(
                                Text(data.currentjour.toString()),
                              ),
                              DataCell(
                                Text('$day/$month/2023'),
                              ),
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
        ]),
      ),
    );
  }
}
