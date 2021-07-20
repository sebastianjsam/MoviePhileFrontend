import 'package:flutter/material.dart';
import 'package:flutter_demo/src/Model/User_Login.dart';

import 'package:flutter_demo/src/services/user_service.dart';

class UserLogin_page extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

// Estructura de la pagina login
// Con sus respectivos campos de email y password
class _LoginPageState extends State<UserLogin_page> {
  UserLogin userLogin;
  final emailCotroler = TextEditingController(text: "jsam@gmail.com");
  final passwordControler = TextEditingController(text: "Aa12345_");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.blue, // color pantalla
      appBar: AppBar(
        centerTitle: true,
        title: Column(children: [
          Text("MoviePhile"),
          GestureDetector(
            child: Text('Debate, Comparte, conoce y acercate al cine',
                style: TextStyle(fontFamily: 'MyFont', fontSize: 10)),
          )
        ]),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                )
              ],
            ),
          ),
          _buildEmail(),
          Divider(),
          _buildPassword(),
          Divider(),
          _buildBtnLogin(),
          Divider(),
          _buildSignupBtn()
        ],
      ),
    );
  }

// Metodo que estructura el campo email
// return el campo de ingresar email
  Widget _buildEmail() {
    return TextField(
      //autofocus: true,
      controller: emailCotroler,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'OpenSans',
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Email',
          labelText: 'Email',
          suffixIcon: Icon(Icons.alternate_email),
          icon: Icon(Icons.email)),
    );
  }

// Metodo que estructura el campo password
// return el campo de ingresar password
  Widget _buildPassword() {
    return TextField(
        //autofocus: true,
        controller: passwordControler,
        obscureText: true,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Password',
            labelText: 'Password',
            suffixIcon: Icon(Icons.lock_open),
            icon: Icon(Icons.lock)));
  }

// Crear  boton de login
  Widget _buildBtnLogin() {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      // width: double.infinity,
      child: RaisedButton(
        child: Text('Login'),
        color: Colors.lightBlue,
        textColor: Colors.black,
        shape: StadiumBorder(),
        onPressed: () {
          userLogin = UserLogin(
              email: emailCotroler.text, password: passwordControler.text);
          getToken(userLogin).then((value) => {
                if (value != null)
                  {Navigator.pushNamed(context, 'Consultar Titulo')}
                else
                  {_buildAlert(context)}
              });
        },
        padding: EdgeInsets.all(15.0),
      ),
    );
  }

// Metodo que estructura al momento de dar un click con una alerta
// return un alerta
//
  void _buildAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Error'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Datos faltantes'),
              // FlutterLogo(size: 100.0)
            ],
          ),
          actions: <Widget>[
            FlatButton(
                child: Text('OK'),
                onPressed: () {
                  // Navigator.pop(context);
                  Navigator.pushNamed(context, '/');
                })
          ],
        );
      },
    );
  }

  Widget _buildSignupBtn() {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      // width: double.minPositive,
      child: RaisedButton(
        child: Text('Sing Up'),
        color: Colors.lightBlue,
        textColor: Colors.black,
        shape: StadiumBorder(),
        onPressed: () {
          Navigator.pushNamed(context, 'Registro Usuario');
        },
        padding: EdgeInsets.all(15.0),
      ),
    );
  }
}
