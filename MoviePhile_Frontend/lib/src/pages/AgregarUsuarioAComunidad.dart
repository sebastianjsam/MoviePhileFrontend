import 'package:flutter/material.dart';
//need create a json with userID+communityID
import 'package:flutter_demo/src/Model/JsonAddUserToCommunity.dart';

import 'package:flutter_demo/src/services/addUserToCommunityService.dart';

class AddUsertToComunity extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<AddUsertToComunity> {
  JsonerAddUserToCommunity jsonUSERTOCOM;
  final comunidadId = 1;
  Future<bool> _seguirOrNot;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //fiml = ModalRoute.of(context).settings.arguments;
      _seguirOrNot = serviceStatusUserCommunity(1);
      setState(() {});
    });
  }

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
                Center(
                  child: Text(
                    'Agregar usuario a comunidad',
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                )
              ],
            ),
          ),
          Divider(),
          containerDatos()
        ],
      ),
    );
  }

  Widget containerDatos() {
    return Container(
      child: FutureBuilder<bool>(
          future: _seguirOrNot,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("snapshot: " + snapshot.data.toString());
              return Column(
                children: [
                  getAddOrRemove(snapshot.data),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("error en la conexión");
            }
            return Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }

  Widget getAddOrRemove(bool selector) {
    if (!selector) {
      return _buildBtnAddUser();
    } else {
      return _buildBtnRemoveUser();
    }
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
                  Navigator.pop(context);
                  //Navigator.pushNamed(context, '/');
                })
          ],
        );
      },
    );
    _seguirOrNot = serviceStatusUserCommunity(1);
    setState(() {});
  }

  Widget _buildBtnAddUser() {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      // width: double.minPositive,
      onPressed: () {},
      // ignore: deprecated_member_use
      child: RaisedButton(
        child: Text('Unirme'),
        color: Colors.lightBlue,
        textColor: Colors.white,
        shape: StadiumBorder(),
        onPressed: () {
          serviceAddUserCommunity(comunidadId).then((value) => {
                if (value)
                  {_buildAlert(context, "Exito", "El usuario fue agregado  ")}
                else
                  {
                    _buildAlert(
                        context, "Error", "El usuario no fue agregado  ")
                  }
              });
        },
        padding: EdgeInsets.all(15.0),
      ),
    );
  }

  Widget _buildBtnRemoveUser() {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      // width: double.minPositive,
      onPressed: () {},
      // ignore: deprecated_member_use
      child: RaisedButton(
        child: Text('Desunirme'),
        color: Colors.grey.shade300,
        textColor: Colors.black,
        shape: StadiumBorder(),
        onPressed: () {
          serviceRemoveUserCommunity(comunidadId).then((value) => {
                if (value)
                  {_buildAlert(context, "Exito", "El usuario fue Eliminado  ")}
                else
                  {
                    _buildAlert(
                        context, "Error", "El usuario no fue eliminado.. ")
                  }
              });
        },
        padding: EdgeInsets.all(15.0),
      ),
    );
  }
}
