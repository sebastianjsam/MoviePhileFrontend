import 'package:flutter/material.dart';
import 'package:flutter_demo/src/Model/Film.dart';
import 'package:flutter_demo/src/Model/User_Login.dart';
import 'package:flutter_demo/src/pages/ConsultCommunity.dart';
import 'package:flutter_demo/src/pages/FilmComment.dart';
import 'package:flutter_demo/src/pages/Registrar_Comunidad.dart';
import 'package:flutter_demo/src/pages/UserLogin_page.dart';
import 'package:flutter_demo/src/services/SearchTitle_service.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  searchTitle_service searchtitleservice = searchTitle_service();
  final myController = TextEditingController();
  Future<List<Film>> _filmsList;

  @override
  void initState() {
    super.initState();
    _filmsList = searchtitleservice.getFilms();
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
                  hintText: "Buscar",
                  labelStyle: TextStyle(fontSize: 24, color: Colors.black),
                  border: InputBorder.none,
                  fillColor: Colors.blue.shade200,
                  filled: true),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                MenuLateral();
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  print(myController.text);
                  _filmsList =
                      searchtitleservice.getFilmsByName(myController.text);
                  setState(() {});
                },
              ),
            ],
          ),
          drawer: MenuLateral(),
          body: FutureBuilder<List<Film>>(
            future: _filmsList,
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
                  child: Text("Detalle"),
                  splashColor: Colors.blue,
                  color: Colors.blueAccent,
                  onPressed: () {
                    Navigator.pushNamed(context, 'CommentFilm',
                        arguments: film.idFilm);
                    //print(film.idFilm);
                  },
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

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text("MoviePhile"),
            accountEmail: Text("MoviePhile@gmail.com"),
          ),
          Ink(
            color: Colors.indigo,
            child: new ListTile(
                title: Text(
                  "Buscar Titulo",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new SearchPage(),
                    ),
                  );
                }),
          ),
          new ListTile(
            title: Text("Registrar Comunidad"),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new Registrar_Comunidad(),
                ),
              );
            },
          ),
          new ListTile(
            title: Text("Consultar Comunidad"),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new ConsultComunityPage(),
                ),
              );
            },
          ),
          new ListTile(
            title: Text("Salir"),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new CommentFilm(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
