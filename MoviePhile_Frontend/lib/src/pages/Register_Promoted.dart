import 'package:flutter/material.dart';
import 'package:flutter_demo/src/Model/Genre.dart';
import 'package:flutter_demo/src/services/AdvertisingService.dart';
//import 'package:flutter_demo/src/Model/Genre.dart';
import 'package:flutter_demo/src/services/Genre.dart';
import 'package:flutter_demo/src/Model/Register_Promoted.dart';
import 'package:flutter_demo/src/pages/ConsultarTitulo_page.dart';
import 'package:flutter_demo/src/services/Register_Promoted.dart';
//import 'package:flutter_demo/src/services/Register_Promoted.dart';
import 'package:flutter_demo/src/services/user_service.dart';
import 'package:getwidget/getwidget.dart';

final valorApagar = TextEditingController(text: "100");
TextEditingController dateCtl = TextEditingController();

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

  List<String> _locations = [
    'Tarjeta Credito',
    'Tarjeta débito',
    'PSE',
  ]; // Option 2
  String _selectedLocation; // Option 2

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
        title: Column(children: [
          Text("MoviePhile"),
          GestureDetector(
            child: Text('Debate, Comparte, conoce y acercate al cine',
                style: TextStyle(fontFamily: 'MyFont', fontSize: 15)),
          )
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(),
            Divider(),
            GFAccordion(
              title: "Registrar titulo",
              collapsedIcon: Icon(Icons.add),
              expandedIcon: Icon(Icons.minimize),
              contentChild: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                children: <Widget>[
                  Text(
                    "Titulo Promocionado",
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
                            idFilm: 99999 + 6,
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
            ),
            Divider(),
            Divider(),
            GFAccordion(
              title: "Realizar Pago",
              collapsedIcon: Icon(Icons.add),
              expandedIcon: Icon(Icons.minimize),
              contentChild: ListView(
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  children: <Widget>[
                    Center(child: Text("Pago")),
                    Row(
                      children: [
                        Expanded(child: Text("Valor a Pagar")),
                        Expanded(child: _buildValorAPagar())
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text("Fecha")),
                        Expanded(child: _buildfecha())
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text("Tipo de pago")),
                        Expanded(
                            child: DropdownButton(
                          hint: Text(
                              'Selecionar Metodo'), // Not necessary for Option 1
                          value: _selectedLocation,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedLocation = newValue;
                            });
                          },
                          items: _locations.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ))
                      ],
                    ),
                    MaterialButton(
                        child: Text('Realizar pago'),
                        color: Colors.blue,
                        textColor: Colors.white,
                        //shape: StadiumBorder(),
                        onPressed: () {
                          advertisingFinalService().then((value) => {
                                if (value)
                                  {
                                    _buildAlertParameter(context, "Exito",
                                        "El Pago se realizo correctamente  ")
                                  }
                                else
                                  {
                                    _buildAlertParameter(context, "Error",
                                        "El pago no se pudo procesar  ")
                                  }
                              });
                        })
                  ]),
            )
          ],
        ),
      ),
    );
  }

// Metodo que estructura al momento de dar un click con una alerta
// return un alerta
//
  void _buildAlertParameter(BuildContext context, String titulo, String texto) {
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

    setState(() {});
  }

  Widget _buildValorAPagar() {
    return TextField(
        //autofocus: true,
        controller: valorApagar,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        ));
  }

  Widget _buildfecha() {
    return TextFormField(
      controller: dateCtl,
      decoration: InputDecoration(
        labelText: "Seleccionar Fecha",
        hintText: "Ex. Insert your dob",
      ),
      onTap: () async {
        DateTime date = DateTime(1900);
        FocusScope.of(context).requestFocus(new FocusNode());

        date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100));

        dateCtl.text = date.toIso8601String();
      },
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
