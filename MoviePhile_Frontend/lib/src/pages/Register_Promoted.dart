import 'package:flutter/material.dart';
import 'package:flutter_demo/src/Model/Genre.dart';
//import 'package:flutter_demo/src/Model/Genre.dart';
import 'package:flutter_demo/src/services/Genre.dart';
import 'package:flutter_demo/src/Model/Register_Promoted.dart';
import 'package:flutter_demo/src/pages/ConsultarTitulo_page.dart';
import 'package:flutter_demo/src/services/Register_Promoted.dart';
//import 'package:flutter_demo/src/services/Register_Promoted.dart';
import 'package:flutter_demo/src/services/user_service.dart';

class PromotedPage extends StatefulWidget {
  @override
  _RegisterPromotedPageState createState() => _RegisterPromotedPageState();
}

class _RegisterPromotedPageState extends State<PromotedPage> {
  RegisterPromoted register;
  GenreService genre = GenreService();
  List<DropdownMenuItem<Genre>> _dropdownMenuItems;
  Genre _selectedgenero;
  Future<List<Genre>> _listGenre;
  //final _id = TextEditingController();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _genero = TextEditingController();

  @override
  void initState() {
    genre.getAllGenre().then((value) => {
          _dropdownMenuItems = buildDropdownMenuItems(value),
          _selectedgenero = _dropdownMenuItems[0].value,
        });
    super.initState();
  }

  List<DropdownMenuItem<Genre>> buildDropdownMenuItems(List genero) {
    List<DropdownMenuItem<Genre>> items = List();
    for (Genre genre in genero) {
      print(genre.name);
      items.add(
        DropdownMenuItem(
          value: genre,
          child: Text(genre.name),
        ),
      );
    }

    return items;
  }

  onChangeDropdownItem(Genre selectedGenre) {
    setState(() {
      _selectedgenero = selectedGenre;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Titulo Promocionado'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          Text(
            "Pelicula promocionada",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50.0,
          ),
          _crearTitulo(),
          Divider(),
          _crearDescripcion(),
          Divider(),
          Text("Seleccione el Generos"),
          DropdownButton(
            value: _selectedgenero,
            items: _dropdownMenuItems,
            onChanged: onChangeDropdownItem,
          ),
          // _crearGenero(),
          Divider(),
          //  _crearPersona(),
          RaisedButton(
            child: Text('Registrar'),
            color: Colors.blue,
            textColor: Colors.white,
            shape: StadiumBorder(),
            onPressed: () {
              // Navigator.pop(context);
              if (_title.text.isEmpty || _description.text.isEmpty) {
                _buildAlert(context);
              } else {
                //print("entro aqui.....");
                register = RegisterPromoted(
                    idFilm: 99999 + 10,
                    titleFilm: _title.text,
                    descriptionFilm: _description.text,
                    idGenre: _selectedgenero.id);
                // print("genero"+ idGenre);
                registerPromoted(register).then((value) => {
                      if (value != null)
                        {
                          //print("entro aqui"),
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new SearchPage(),
                            ),
                          )
                        }
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
  Widget _crearTitulo() {
    return TextField(
        //autofocus: true,
        controller: _title,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          counter: Text('letras 100'),
          hintText: 'Titulo',
          labelText: 'Titulo',
          //  suffixIcon: Icon(Icons.accessibility),
          //  icon: Icon(Icons.account_circle)
        ));
  }

  Widget _crearDescripcion() {
    return TextField(
        //autofocus: true,
        controller: _description,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Descripcion',
            labelText: 'Descripcion'
            // suffixIcon: Icon(Icons.alternate_email)
            //icon: Icon(Icons.email)
            ));
  }

// Metodo que estructura el campo password
// return el campo de ingresar password
  Widget _crearGenero() {
    return TextField(
        //autofocus: true,
        controller: _genero,
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Genero',
          labelText: 'Genero',
          // suffixIcon: Icon(Icons.lock_open),
          //icon: Icon(Icons.lock)
        ));
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
