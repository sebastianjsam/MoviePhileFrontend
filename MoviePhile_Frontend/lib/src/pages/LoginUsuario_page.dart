import 'package:flutter/material.dart';

class LoginUsuarioPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

// Estructura de la pagina login
// Con sus respectivos campos de email y password
class _LoginPageState extends State<LoginUsuarioPage> {
  String _email = '';
  String _password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(children: [
          Text("MoviePhile"),
          GestureDetector(
            child: Text('Debate, Comparte, conoce y acercate al cine',
                style: TextStyle(fontFamily: 'MyFont', fontSize: 15)),
          )
        ]),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _crearEmail(),
          Divider(),
          _crearContrasena(),
          Divider(),
          _crearPersona(),
          RaisedButton(
            child: Text('Ingresar'),
            color: Colors.blue,
            textColor: Colors.white,
            shape: StadiumBorder(),
            onPressed: () {
              _mensaje(context);
            },
          ),
        ],
      ),
    );
  }

// Metodo que estructura el campo email
// return el campo de ingresar email
  Widget _crearEmail() {
    return TextField(
      //autofocus: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Email',
          labelText: 'Email',
          suffixIcon: Icon(Icons.alternate_email),
          icon: Icon(Icons.email)),
      onChanged: (valor) {
        setState(() {
          _email = valor;
        });
      },
    );
  }

// Metodo que estructura el campo password
// return el campo de ingresar password
  Widget _crearContrasena() {
    return TextField(
      //autofocus: true,
      obscureText: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Password',
          labelText: 'Password',
          suffixIcon: Icon(Icons.lock_open),
          icon: Icon(Icons.lock)),
      onChanged: (valor) {
        setState(() {
          _password = valor;
        });
      },
    );
  }

// Metodo que estructura al momento de dar un click con una alerta
// return un alerta
  void _mostrarAlerta(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Datos Faltantes'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Llenar campos vacios'),
              // FlutterLogo(size: 100.0)
            ],
          ),
          actions: <Widget>[
            FlatButton(
                child: Text('OK'),
                onPressed: () {
                  // Navigator.pop(context);
                  Navigator.pushNamed(context, 'avatar');
                })
          ],
        );
      },
    );
  }

  Widget _crearPersona() {
    return ListTile(
      title: Text('Nombre es: $_email' + ' Apellido es $_password'),
    );
  }

  void _mensaje(BuildContext context) {
    if ('$_email' != null && '$_password' != null) {
      _mostrarAlerta(context);
    } else {
      print('entro,,,ksajdkjask');
    }
  }
}
