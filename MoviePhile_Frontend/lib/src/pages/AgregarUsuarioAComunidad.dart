import 'dart:convert';

import 'package:flutter/material.dart';
//need create a json with userID+communityID
import 'package:flutter_demo/src/Model/JsonAddUserToCommunity.dart';
//Send jsonUSERTOCOM to the server
import 'package:flutter_demo/src/services/addUserToCommunityService.dart';


class AddUsertToComunity extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

// Estructura de la agregar usuario a comunidad
//  Json{
//   "communityId": #,
//   "userId": "str"
// }
class _LoginPageState extends State<AddUsertToComunity> {
  JsonerAddUserToCommunity jsonUSERTOCOM;
  final comunidadId = TextEditingController();
  final userId = TextEditingController();

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
                  'Agregar usuario a comunidad',
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
          _buildComunityID(),
          Divider(),
          _buildUserID(),
          Divider(),
          _buildBtnAddUser(),
        ],
      ),
    );
  }

// inputText+caja  Comunidad ID
  Widget _buildComunityID() {
    return TextField(
      //autofocus: true,
      controller: comunidadId,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'OpenSans',
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Id comunidad',
          labelText: 'Id comunidad',
          suffixIcon: Icon(Icons.add),
          icon: Icon(Icons.add)),
    );
  }

// Metodo que estructura el campo id usuario
  Widget _buildUserID() {
    return TextField(
      //autofocus: true,
        controller: userId,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'ID usuario',
            labelText: 'ID usuario',
            suffixIcon: Icon(Icons.add),
            icon: Icon(Icons.add)));
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
          //userLogin = UserLogin(
          //    email: emailCotroler.text, password: passwordControler.text);
          //getToken(userLogin).then((value) => {
          //  if (value != null)
           //   {Navigator.pushNamed(context, '/')}
           // else
          //    {_buildAlert(context)}
          //});
        },
        padding: EdgeInsets.all(15.0),
      ),
    );
  }

// Metodo que estructura al momento de dar un click con una alerta
// return un alerta
//
  void _buildAlert(BuildContext context, String titulo, String texto) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(titulo),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(texto),
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

  Widget _buildBtnAddUser() {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      // width: double.minPositive,
      child: RaisedButton(
        child: Text('Agregar'),
        color: Colors.lightBlue,
        textColor: Colors.black,
        shape: StadiumBorder(),
        onPressed: () {
          //TODO
          //Create a userxcommunity obj
          jsonUSERTOCOM = JsonerAddUserToCommunity(
            communityId: int.parse(comunidadId.text), userId: userId.text
          );

          serviceAddUserCommunity(jsonUSERTOCOM).then((value) =>{

            if(value){
              _buildAlert(context, "Exito", "El usuario fue agregado")
            }else{
              _buildAlert(context, "Error", "El usuario no fue agregado")
            }

          });

          _buildAlert(context, "Datos enviados", "loco loco");
        },
        padding: EdgeInsets.all(15.0),
      ),
    );
  }
}