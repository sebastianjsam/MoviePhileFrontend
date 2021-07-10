import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_demo/src/Model/Comunity.dart';
import 'package:flutter_demo/src/services/RegistrarComunidadService.dart';

class Registrar_Comunidad extends StatefulWidget{
  @override
  _Registrar_Comunidad createState() => _Registrar_Comunidad();

}

class _Registrar_Comunidad extends State<Registrar_Comunidad> {

  String name;
  String description;
  Comunity comunity;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
          title: Text("Registrar comunidad")
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
            _setName(),
            Divider(),
            _setDescription(),
            RaisedButton(
              child: Text('Crear'),
              color: Colors.blue,
              textColor: Colors.white,
              shape: StadiumBorder(),
              onPressed: () {
                comunity = Comunity(id: 999, name: name, description: description, genres: null, publications: null, users: null);

                POSTRegistrarComunidad(comunity).then((value) => {

                  if(value){
                    _buildAlert(context, "Creada...", "Crear comunidad.")
                  }else{
                    _buildAlert(context, "Error...", "No se pudo crear la comunidad.")
                  }

                });

              },
            )


        ],
      ),
    );
  }



  Widget _setName() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          counter: Text('letras 100'),
          hintText: 'Nombre comunidad',
          labelText: 'nombre comunidad',
          helperText: 'Solo nombre',
          suffixIcon: Icon(Icons.widgets),
          icon: Icon(Icons.add)),
      onChanged: (valor) {
        setState(() {
             name = valor;
        });
      },



    );
  }


  Widget _setDescription(){

    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          counter: Text('letras 100'),
          hintText: 'sobre la comunidad',
          labelText: 'sobre la comunidad',
          helperText: 'Solo texto',
          suffixIcon: Icon(Icons.add_business),
          icon: Icon(Icons.add)),
      onChanged: (valor) {
        setState(() {
          description = valor;
        });
      },



    );
  }


  void _buildAlert(BuildContext context, String titulo, String mensaje) {
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
              Text(mensaje),
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
