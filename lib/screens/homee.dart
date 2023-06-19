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
                    '/logo2.png',
                    width: 130,
                  ),
                ],
              ),
            ),
            const Positioned(
              top: 200,
              left: 270,
              right: 0,
              child: Center(
                child: Text(
                  'Réservez voyage',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Positioned(
              top: 280,
              left: 250,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Fromto(
                                  test: '0',
                                )));
                  },
                  child: Text('Try It'),
                ),
              ),
            ),
            Positioned(
                top: 170,
                left: 15,
                right: 15,
                child: Container(
                  width: 300,
                  height: 200,
                  child: Stack(children: [
                    SizedBox(
                      width: 240,
                      height: 250, // Set the desired width
                      child: Image.asset(
                        'reserv3.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ]),
                )),
            Positioned(
                top: 350,
                left: 15,
                right: 15,
                child: Container(
                  width: 300,
                  height: 200,
                  child: Stack(children: [
                    Positioned(
                      left: 130,
                      child: SizedBox(
                        width: 270,
                        height: 250, // Set the desired width
                        child: Image.asset(
                          'teaam3.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  ]),
                )),
            Positioned(
              top: 420,
              left: 10,
              right: 0,
              child: Text(
                'Notre équipe',
                style: TextStyle(fontSize: 25),
              ),
            ),
            Positioned(
              top: 460,
              left: 20,
              right: 250,
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
