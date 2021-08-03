import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLoginButton extends StatelessWidget {
  final String text;
  final Color colorText;
  final Color colorButtonBackground;
  final Widget widgetToNavigate;

  MyLoginButton(
      {this.text,
      this.colorText,
      this.colorButtonBackground,
      this.widgetToNavigate});

  @override
  Widget build(Object context) {
    return Container(
      padding: EdgeInsets.only(top: 50.0, bottom: 25),
      width: double.infinity,
      child: RaisedButton(
        color: colorButtonBackground,
        elevation: 5.0,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: colorText,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => widgetToNavigate));
        },
      ),
    );
  }
}
