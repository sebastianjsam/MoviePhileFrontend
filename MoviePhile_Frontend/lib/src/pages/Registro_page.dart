import 'package:flutter/material.dart';
import 'package:flutter_demo/src/Model/User.dart';
import 'package:flutter_demo/src/services/user_service.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  User user;
  final _id = TextEditingController();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
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
          Text(
            'Registrar Usuario',
            style: TextStyle(fontFamily: 'MyFont', fontSize: 25),
            textAlign: TextAlign.center,
          ),
          Divider(),
          Divider(),
          _crearNombre(),
          Divider(),
          // _crearApellido(),
          // Divider(),
          // _crearEdad(),
          // Divider(),
          _crearEmail(),
          Divider(),
          _crearContrasena(),
          Divider(),
          //  _crearPersona(),
          RaisedButton(
            child: Text('Registrar'),
            color: Colors.blue,
            textColor: Colors.white,
            shape: StadiumBorder(),
            onPressed: () {
              // Navigator.pop(context);
              if (_name.text.isEmpty ||
                  _email.text.isEmpty ||
                  _password.text.isEmpty) {
                _buildAlert(context);
              } else {
                user = User(
                    userName: _name.text,
                    email: _email.text,
                    password: _password.text);

                register(user).then((value) => {
                      if (value != null)
                        {Navigator.pushNamed(context, 'Consultar Titulo')}
                      else
                        {
                          // _buildAlert(context)
                        }
                    });
              }
            },
          ),
        ],
      ),
    );
  }

// Metodo que estructura el campo del nombre de usuario
// return el campo de ingresar en nombre
  Widget _crearNombre() {
    return TextField(
        //autofocus: true,
        controller: _name,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            counter: Text('letras 100'),
            hintText: 'Nombre de usuario',
            labelText: 'Nombre de usuario',
            suffixIcon: Icon(Icons.accessibility),
            icon: Icon(Icons.account_circle)));
  }

// Metodo que estructura el campo del nombre de apellido
// return el campo de ingresar en apellido
  // Widget _crearApellido() {
  //   return TextField(
  //     //autofocus: true,
  //     textCapitalization: TextCapitalization.sentences,
  //     decoration: InputDecoration(
  //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
  //         counter: Text('letras 100'),
  //         hintText: 'Apellido usuario',
  //         labelText: 'Apellido',
  //         helperText: 'Solo apellido',
  //         suffixIcon: Icon(Icons.accessibility),
  //         icon: Icon(Icons.account_circle)),
  //     onChanged: (valor) {
  //       setState(() {
  //         _apellido = valor;
  //       });
  //     },
  //   );
  // }

  // Widget _crearEdad() {
  //   return TextField(
  //     //autofocus: true,
  //     textCapitalization: TextCapitalization.sentences,
  //     decoration: InputDecoration(
  //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
  //         counter: Text('letras 100'),
  //         hintText: 'Registrar Edad',
  //         labelText: 'Edad',
  //         helperText: 'Solo edad',
  //         suffixIcon: Icon(Icons.accessibility),
  //         icon: Icon(Icons.account_circle)),
  //     onChanged: (valor) {
  //       setState(() {
  //         _apellido = valor;
  //       });
  //     },
  //   );
  // }

  // Metodo que estructura el campo email
// return el campo de ingresar email
  Widget _crearEmail() {
    return TextField(
        //autofocus: true,
        controller: _email,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Correo electrónico',
            labelText: 'Correo electrónico',
            suffixIcon: Icon(Icons.alternate_email),
            icon: Icon(Icons.email)));
  }

// Metodo que estructura el campo password
// return el campo de ingresar password
  Widget _crearContrasena() {
    return TextField(
        //autofocus: true,
        controller: _password,
        obscureText: true,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Contraseña',
            labelText: 'Contraseña',
            suffixIcon: Icon(Icons.lock_open),
            icon: Icon(Icons.lock)));
  }

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
            ],
          ),
          actions: <Widget>[
            FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }
}
