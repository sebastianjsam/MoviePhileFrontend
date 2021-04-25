import 'package:flutter/material.dart';
import 'package:flutter_demo/src/Model/Login_Usuario.dart';
import 'package:flutter_demo/src/services/user_service.dart';

class LoginUsuarioPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

// Estructura de la pagina login
// Con sus respectivos campos de email y password
class _LoginPageState extends State<LoginUsuarioPage> {
  UserLogin userLogin;
  final emailCotroler = TextEditingController();
  final passwordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Sing In',
                  style: TextStyle(
                    color: Colors.blue,
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
          _crearEmail(),
          Divider(),
          _crearContrasena(),
          Divider(),
          _crearBtnLogin(),
        ],
      ),
    );
  }

// Metodo que estructura el campo email
// return el campo de ingresar email
  Widget _crearEmail() {
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
  Widget _crearContrasena() {
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
  Widget _crearBtnLogin() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        child: Text('Login'),
        color: Colors.blue,
        textColor: Colors.black,
        shape: StadiumBorder(),
        onPressed: () {
          userLogin = UserLogin(
              email: emailCotroler.text, password: passwordControler.text);
          getToken(userLogin).then((value) => {
                if (value != null)
                  {Navigator.pushNamed(context, '/')}
                else
                  {_mostrarAlerta(context)}
              });
        },
        padding: EdgeInsets.all(15.0),
      ),
    );
  }

// Metodo que estructura al momento de dar un click con una alerta
// return un alerta
//
  void _mostrarAlerta(BuildContext context) {
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
}
