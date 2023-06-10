import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pfeflutter/models/employe.dart';
import 'package:pfeflutter/models/entreprise.dart';
import 'package:pfeflutter/screens/conjii.dart';
import 'package:pfeflutter/screens/consulterdemande.dart';
import 'package:pfeflutter/screens/pointage.dart';
import 'package:http/http.dart' as http;
import 'package:pfeflutter/screens/profileemp.dart';
import 'package:pfeflutter/services/user_service.dart';
import 'package:pfeflutter/services/voyage_service.dart';

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
                          '/last1.png',
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
                        "référence à l'enregistrement des heures travaillées par les employés ",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 220,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => pointge(
                                        iduser: iddd,
                                        entrename: entreprsiename,
                                        email: email,
                                      )));
                        },
                        child: Text('Try It'),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 280,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'Demonde Conji here',
                        style: TextStyle(fontSize: 30, color: Colors.black45),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 330,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      Dconji(iduser: iddd, ident: entre)));
                        },
                        child: Text('conjii demonde'),
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
                      title: Text(' Suivi Demande '),
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
