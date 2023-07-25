import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:pfeflutter/models/employe.dart';
import 'package:pfeflutter/models/entreprise.dart';
import 'package:pfeflutter/screens/conjii.dart';
import 'package:pfeflutter/screens/consulterdemande.dart';
import 'package:pfeflutter/screens/fromTo.dart';
import 'package:pfeflutter/screens/homee.dart';
import 'package:pfeflutter/screens/pointage.dart';
import 'package:http/http.dart' as http;
import 'package:pfeflutter/screens/profileemp.dart';
import 'package:pfeflutter/services/user_service.dart';

class Employerdash extends StatefulWidget {
  String iduser;
  Employerdash({
    Key? key,
    required this.iduser,
  }) : super(key: key);

  @override
  State<Employerdash> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Employerdash> {
  List<Entreprise> entr = [];
  List<Employe> em = [];
  String entreprsiename = 'zzzzr';
  String email = 'zzzz';

  String entre = "";
  Future<List<Employe>> fetchDataaa(String iduser) async {
    var url = Uri.parse('http://127.0.0.1:8000/api/getemploye/$iduser');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Successful request, parse the response body
      List jsonData = jsonDecode(response.body);
      em = jsonData.map((data) => Employe.fromJson(data)).toList();
      print(iduser);
      // Process the data as needed

      email = em[0].adresse.toString();
      var id = em[0].entrepriseId;
      entre = em[0].entrepriseId.toString();

      var url = Uri.parse('http://127.0.0.1:8000/api/entre/$id');
      final responsee = await http.get(url);
      if (responsee.statusCode == 200) {
        List jsonResponse = json.decode(responsee.body);
        entr = jsonResponse.map((data) => Entreprise.fromJson(data)).toList();

        entreprsiename = entr[0].name.toString();

        print(entreprsiename);
      } else {
        throw Exception('Unexpected error occured!');
      }
      return (em);
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    String iddd = widget.iduser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<List<Employe>>(
        future: fetchDataaa(iddd),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Home page'),
              ),
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
                      top: 170,
                      left: 15,
                      right: 15,
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
                        height: 150,
                        child: Stack(children: [
                          SizedBox(
                            width: 240,
                            height: 250, // Set the desired width
                            child: Image.asset(
                              'point.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ]),
                      )),
                  Positioned(
                    top: 180,
                    left: 220,
                    right: 50,
                    child: Text(
                      "𝓹𝓸𝓲𝓷𝓽𝓪𝓰𝓮 ",
                      style: TextStyle(fontSize: 23, color: Colors.black),
                    ),
                  ),
                  Positioned(
                    top: 230,
                    left: 230,
                    right: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => pointge(
                                      iduser: iddd,
                                      entrename: entreprsiename,
                                      email: email,
                                      emppp: snapshot.data![0],
                                    )));
                      },
                      child: Text('Pointer'),
                    ),
                  ),
                  Positioned(
                      top: 350,
                      left: 15,
                      right: 15,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(6, 5, 5, 5),
                                Color.fromARGB(255, 232, 233, 234),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 300,
                        height: 150,
                        child: Stack(children: [
                          SizedBox(
                            width: 240,
                            height: 250, // Set the desired width
                            child: Image.asset(
                              'demonde.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ]),
                      )),
                  Positioned(
                    top: 370,
                    left: 220,
                    right: 50,
                    child: Center(
                      child: Text(
                        '𝓓𝓮𝓶𝓪𝓷𝓭𝓮 𝓒𝓸𝓷𝓰é',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 430,
                    left: 230,
                    right: 40,
                    child: Container(
                      width: 80,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        Dconji(iduser: iddd, ident: entre)));
                          },
                          child: Text('  Demonder  '),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 530,
                      left: 15,
                      right: 15,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(6, 5, 5, 5),
                                Color.fromARGB(255, 9, 145, 223),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 300,
                        height: 150,
                        child: Stack(children: [
                          SizedBox(
                            width: 240,
                            height: 250, // Set the desired width
                            child: Image.asset(
                              'reservationem.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ]),
                      )),
                  Positioned(
                    top: 550,
                    left: 210,
                    right: 50,
                    child: Center(
                      child: Text(
                        '𝓡𝓮𝓼𝓮𝓻𝓿𝓪𝓽𝓲𝓸𝓷',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 610,
                    left: 230,
                    right: 40,
                    child: Container(
                      width: 40,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Fromto(
                                          test: iddd,
                                        )));
                          },
                          child: Text('  Reserver  '),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Stack(children: [
                        Positioned(
                          top: 10,
                          child: Text(
                            '$entreprsiename',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          child: Text(
                            '$email',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ]),
                    ),
                    ListTile(
                      title: Text('Logout'),
                      onTap: () {
                        logout();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => HomePage()));
                      },
                    ),
                    ListTile(
                      title: Text('Profile '),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Profile(
                                      em: em[0],
                                    )));
                      },
                    ),
                    ListTile(
                      title: Text(' Suivi Demandes '),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Demande(
                                      iduser: iddd,
                                      entrename: entreprsiename,
                                      email: email,
                                    )));
                        // Handle option 2
                      },
                    ),
                    // Add more ListTile widgets for additional options
                  ],
                ),
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
