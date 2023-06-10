import 'package:flutter/material.dart';

const baseURL = 'http://127.0.0.1:8000/api';
const loginURL = baseURL + '/login';
const registerURL = 'http://127.0.0.1:8000/api/signup';
const logoutURL = baseURL + '/logout';
const userURL = baseURL + '/user';
const postURL = baseURL + '/posts';
const stripepublishkey =
    "pk_test_51Mb8geHWoFEzXDnr3BCgrZURIMksY5x3755j0QNqQlgY35vwfuDthObMtWDw9K5dYhV0Oc56tPmpHiNaB7TqoG6m00bHLXoFZI";

const serverError = 'server error';
const unauthorized = 'Unauthorized';

const somthingwentwrong = 'somthin went wrong ,try again!';

//loginregister hint
Row kLoginRegisterHint(String text, String label, Function ontTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
        child: Text(label, style: TextStyle(color: Colors.blue)),
        onTap: () => ontTap(),
      )
    ],
  );
}

//buttonlogreg
TextButton kbutton(String text, Function onPressed) {
  return TextButton(
    child: Text(
      text,
      style: TextStyle(color: Colors.white),
    ),
    style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.blue),
        padding: MaterialStateProperty.resolveWith(
            (states) => EdgeInsets.symmetric(vertical: 10))),
    onPressed: () => onPressed(),
  );
}

TextButton kbotconji(String text, Function onPressed) {
  return TextButton(
    child: Text(
      text,
      style: TextStyle(color: Colors.white),
    ),
    style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(
          Size(50, 50), // Set the desired width and height here
        ),
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.black),
        padding: MaterialStateProperty.resolveWith(
            (states) => EdgeInsets.symmetric(vertical: 10))),
    onPressed: () => onPressed(),
  );
}
