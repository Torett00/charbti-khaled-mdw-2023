import 'package:pfeflutter/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:pfeflutter/constant.dart';
import 'package:pfeflutter/models/ligne.dart';
import 'package:pfeflutter/models/voyage.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

List<Ligne> _filteredPersonList = [];

String? id;
int? idd;
// loginnn
Future<String> getligneid(String from, String to) async {
  return (from);
}

Future<int> get() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('userid') ?? 0;
}
//register
