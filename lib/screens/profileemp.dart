import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pfeflutter/models/employe.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  Employe em;
  Profile({
    Key? key,
    required this.em,
  }) : super(key: key);

  @override
  State<Profile> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Profile> {
  void updateData(
      String nom, String tel, String add, String pos, String sal) async {
    String idd = widget.em.userId.toString();
    print(idd);
    var url = Uri.parse('http://127.0.0.1:8000/api/putemploye/$idd');

    try {
      var response = await http.put(
        url,
        body: {
          'name': nom,
          'telephone': tel,
          'adresse': add,
          'poste': pos,
          'salaire': sal,
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController txtname = TextEditingController();
  TextEditingController txtaddress = TextEditingController();
  TextEditingController txttelphone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Employe emp = widget.em;

    String name = emp.name.toString();
    String address = emp.adresse.toString();
    String tele = emp.telephone.toString();
    String saliree = emp.salaire.toString();
    String rol = emp.poste.toString();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 50,
            right: 50,
            child: Text(
              'Profile:',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Positioned(
            top: 200,
            left: 50,
            right: 50,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Positioned(
                    top: 220,
                    left: 0,
                    right: 0,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: '$name'),
                      controller: txtname,
                      validator: (val) =>
                          val!.isEmpty ? 'required at least 6 chars ' : null,
                    ),
                  ),
                  Positioned(
                    top: 220,
                    left: 40,
                    right: 0,
                    child: Text('Name'),
                  ),
                  Positioned(
                    top: 250,
                    left: 0,
                    right: 0,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: '$tele'),
                      controller: txttelphone,
                      validator: (val) =>
                          val!.isEmpty ? 'required at least 6 chars ' : null,
                    ),
                  ),
                  Positioned(
                    top: 250,
                    left: 40,
                    right: 0,
                    child: Text('Telephone'),
                  ),
                  Positioned(
                    top: 280,
                    left: 0,
                    right: 0,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: '$address'),
                      controller: txtaddress,
                      validator: (val) =>
                          val!.isEmpty ? 'required at least 6 chars ' : null,
                    ),
                  ),
                  Positioned(
                    top: 280,
                    left: 40,
                    right: 0,
                    child: Text('Addresse'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        updateData(txtname.text, txttelphone.text,
                            txtaddress.text, saliree, rol);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
