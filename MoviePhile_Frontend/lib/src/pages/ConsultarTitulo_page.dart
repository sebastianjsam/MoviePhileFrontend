import 'package:flutter/material.dart';
import 'package:flutter_demo/src/Model/Film.dart';
import 'package:flutter_demo/src/services/consultarTitulo_service.dart';

class ConsultarPage extends StatefulWidget {
  @override
  _ConsultarPageState createState() => _ConsultarPageState();
}

class _ConsultarPageState extends State<ConsultarPage> {
  consultarTitulo_service consultartituloservice = consultarTitulo_service();
  final myController = TextEditingController();
  Future<List<Film>> _listadoFilms;

  @override
  void initState() {
    super.initState();
    _listadoFilms = consultartituloservice.getFilms();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaterialApp',
      home: Scaffold(
          appBar: AppBar(
            title: TextField(
              controller: myController,
              decoration: InputDecoration(
                  hintText: "search",
                  labelStyle: TextStyle(fontSize: 24, color: Colors.black),
                  border: InputBorder.none,
                  fillColor: Colors.blue.shade200,
                  filled: true),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  print(myController.text);
                  _listadoFilms =
                      consultartituloservice.getFilmsByName(myController.text);
                  setState(() {});
                },
              ),
            ],
          ),
          body: FutureBuilder<List<Film>>(
            future: _listadoFilms,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: _listFilms(snapshot.data),
                );
              } else if (snapshot.hasError) {
                return Text("error");
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }

  List<Widget> _listFilms(List<Film> data) {
    List<Widget> films = [];
    for (var film in data) {
      films.add(Card(
          child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text(
                film.nameFilm,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.red),
                textAlign: TextAlign.center,
              )),
          Expanded(child: Image.network(film.urlImage, fit: BoxFit.fill)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonTheme(
                minWidth: 10.0,
                height: 25.0,
                child: FlatButton(
                  child: Text("Details"),
                  splashColor: Colors.blue,
                  color: Colors.blueAccent,
                  onPressed: () {},
                ),
              )
            ],
          )
        ],
      )));
    }
    return films;
  }
}
