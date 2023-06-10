import 'package:flutter/material.dart';
import 'package:pfeflutter/screens/fromTo.dart';
import 'package:pfeflutter/screens/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
              left: 15,
              right: 15,
              child: Center(
                child: Text(
                  'Réservez vos billets de train, de bus et davion',
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
                        context, MaterialPageRoute(builder: (_) => Fromto()));
                  },
                  child: Text('Try It'),
                ),
              ),
            ),
            Positioned(
              top: 320,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Our team',
                  style: TextStyle(fontSize: 30, color: Colors.black45),
                ),
              ),
            ),
            Positioned(
              top: 370,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => Login()));
                  },
                  child: Text('Login'),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
