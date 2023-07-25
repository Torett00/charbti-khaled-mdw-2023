import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:pfeflutter/constant.dart';
import 'package:pfeflutter/models/api_response.dart';
import 'package:pfeflutter/models/employe.dart';
import 'package:pfeflutter/models/fiched.dart';
import 'package:pfeflutter/models/pointage.dart';
import 'package:http/http.dart' as http;
import 'package:pfeflutter/screens/employe.dart';

import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'mobile.dart' if (dart.library.html) 'web.dart';

class pointge extends StatefulWidget {
  String iduser;
  String entrename;
  String email;
  Employe emppp;
  pointge({
    Key? key,
    required this.iduser,
    required this.entrename,
    required this.email,
    required this.emppp,
  }) : super(key: key);

  @override
  State<pointge> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<pointge> {
  List<Employe> empp = [];
  String idd = '';
  List<Pointage> pointages = [];
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<ApiResponse> ajouterfiche(String nbrj, String sal, String nbr,
      String iduserr, String identreprise) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http
          .post(Uri.parse('http://127.0.0.1:8000/api/newfiche'), headers: {
        'Accept': 'Application/json'
      }, body: {
        'nombredejour': nbrj,
        'salaire': sal,
        'conjirestant': nbr,
        'user_id': iduserr,
        'entreprise_id': identreprise,
      });
      switch (response.statusCode) {
        case 200:
          apiResponse.data = Fichede.fromJson(jsonDecode(response.body));

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

    return apiResponse;
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();

    final page = document.pages.add();

    page.graphics.drawString(
        'Fiche de paie!!!', PdfStandardFont(PdfFontFamily.helvetica, 28),
        brush: PdfBrushes.black, bounds: Rect.fromLTWH(150, 10, 300, 50));
    page.graphics.drawString(
        '${widget.entrename}', PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.black, bounds: Rect.fromLTWH(10, 40, 300, 50));
    page.graphics.drawString(
        '${widget.email}', PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.black, bounds: Rect.fromLTWH(10, 70, 300, 50));
    PdfGrid grid = PdfGrid();

//Add the columns to the grid
    grid.columns.add(count: 4);

//Add header to the grid
    grid.headers.add(1);

//Add the rows to the grid
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'nombre d jour';
    header.cells[1].value = 'Saliree';
    header.cells[2].value = 'conji restant';
    header.cells[3].value = 'Saliree res';

//Add rows to grid
    PdfGridRow row = grid.rows.add();
    row.cells[0].value = '${pointages[0].nombredejour}';
    row.cells[1].value = '${widget.emppp.salaire}';
    row.cells[2].value = '${pointages[0].conjirestant}';
    row.cells[3].value = 'not yeet';

//Set the grid style
    grid.style = PdfGridStyle(
        cellPadding: PdfPaddings(left: 2, right: 3, top: 4, bottom: 5),
        backgroundBrush: PdfBrushes.white,
        textBrush: PdfBrushes.black,
        font: PdfStandardFont(PdfFontFamily.timesRoman, 20));

//Draw the grid
    grid.draw(page: page, bounds: const Rect.fromLTWH(0, 300, 0, 0));

    PdfGrid grid2 = PdfGrid();

//Add the columns to the grid
    grid2.columns.add(count: 2);

//Add header to the grid
    grid2.headers.add(1);

//Add the rows to the grid
    PdfGridRow header2 = grid2.headers[0];
    header2.cells[0].value = 'Poste';
    header2.cells[1].value = '${widget.emppp.poste}';

//Add rows to grid
    PdfGridRow row2 = grid2.rows.add();
    row2.cells[0].value = 'Date';
    row2.cells[1].value = '${datelyoum}';

    PdfGridRow row3 = grid2.rows.add();
    row3.cells[0].value = 'Salaire de bas';
    row3.cells[1].value = '${widget.emppp.salaire}';

//Set the grid style
    grid2.style = PdfGridStyle(
        cellPadding: PdfPaddings(left: 2, right: 3, top: 4, bottom: 5),
        backgroundBrush: PdfBrushes.white,
        textBrush: PdfBrushes.black,
        font: PdfStandardFont(PdfFontFamily.timesRoman, 20));

//Draw the grid
    grid2.draw(page: page, bounds: const Rect.fromLTWH(150, 100, 300, 300));

    List<int> bytes = await document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Output.pdf');
  }

  Future<Uint8List> _readImageData(String name) async {
    final data = await rootBundle.load('images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
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
            top: 110,
            left: 220,
            child: Container(
                width: 120,
                child: ElevatedButton.icon(
                  onPressed: () {
                    point();
                  },
                  icon: Icon(Icons.add_box), // Replace with your desired icon
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
                              label: Text(
                                'nombre de jour travallie',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none),
                              ),
                              numeric: false),
                          DataColumn(
                              label: Text(
                                'dernier jour pointage',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none),
                              ),
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
                                Text(data.nombredejour.toString(),
                                    style: TextStyle(fontSize: 20)),
                              ),
                              DataCell(
                                Text('$day/$month/2023',
                                    style: TextStyle(fontSize: 20)),
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
          Positioned(
            top: 500,
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
                    'Telecharger fiche de paie',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Positioned(
                    top: 60,
                    left: 10,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _createPDF();
                        ajouterfiche(
                            pointages[0].nombredejour.toString(),
                            widget.emppp.salaire.toString(),
                            pointages[0].conjirestant.toString(),
                            widget.iduser.toString(),
                            widget.emppp.entrepriseId.toString());
                      },
                      icon: Icon(
                          Icons.download), // Replace with your desired icon
                      label: Text('telecharger '),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Set the background color
                        // You can also customize other properties like padding, shape, etc.
                      ),

                      // Replace with your desired label
                    )),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
