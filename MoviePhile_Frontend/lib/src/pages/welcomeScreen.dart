import 'package:flutter/material.dart';

import 'DesignWidgets.dart';

import 'Registro_page.dart';
import 'UserLogin_page.dart';
import 'mySignUpLabelButton.dart';
import 'myLoginButton.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

Widget _signUpButton(BuildContext context) {
  return Container(
    width: double.infinity,
    child: OutlineButton(
      borderSide: BorderSide(color: Colors.white),
      highlightedBorderColor: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        "Register",
        style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegistroPage()));
      },
    ),
  );
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
          //se respeta las margenes laterales
          padding: EdgeInsets.symmetric(horizontal: 20),
          //cogemps el alto de la pantalla del dispositivo
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          decoration: BoxDecoration(
            gradient: DesignWidgets.linearGradientMain(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DesignWidgets.tittleCustom(),
              MyLoginButton(
                text: "Login",
                colorText: Theme.of(context).primaryColor,
                colorButtonBackground: Colors.white,
                widgetToNavigate: UserLogin_page(),
              ),
              _signUpButton(context),
            ],
          ),
        )),
      ),
    );
  }
}
