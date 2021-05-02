import 'package:flutter/material.dart';
import 'package:flutter_demo/src/Model/Comunity.dart';
import 'package:flutter_demo/src/Model/Film.dart';
import 'package:flutter_demo/src/services/ConsultComunityService.dart';

class ConsultComunityPage extends StatefulWidget {
  @override
  _ConsultComunityPageState createState() => _ConsultComunityPageState();
}

class _ConsultComunityPageState extends State<ConsultComunityPage> {
  ConsultComunityService consultComunityService = ConsultComunityService();
  final myController = TextEditingController();
  Future<List<Comunity>> _listadoFilms;

  @override
  void initState() {
    super.initState();
    _listadoFilms = consultComunityService.getAllComunity();
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
              onPressed: () {
                _listadoFilms = consultComunityService.getComunityByName('');
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  print(myController.text);
                  _listadoFilms = consultComunityService
                      .getComunityByName(myController.text);
                  setState(() {});
                },
              ),
            ],
          ),
          body: Column(
            children: [
              FutureBuilder<List<Comunity>>(
                future: _listadoFilms,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Container(
                            child: Text(
                          "Comunidades",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                        Container(
                          //width: MediaQuery.of(context).size.width * 0.5,
                          child: _listComunity(snapshot),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      "error",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          )),
    );
  }

  ListView _listComunity(snapshot) {
    return ListView.builder(
        padding: EdgeInsets.all(10), //espaciado
        scrollDirection:
            Axis.vertical, //obligatorio declarar width para evitar error
        //reverse: true,
        //scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Card(
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Image.network(
                        "https://image.tmdb.org/t/p/w500/inJjDhCjfhh3RtrJWBmmDqeuSYC.jpg",
                        fit: BoxFit.fill),
                  ),
                  Container(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            snapshot.data[index].name.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            snapshot.data[index].description.toString(),
                            textAlign: TextAlign.left,
                          ),
                          Text("02/05/2021")
                        ],
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 10.0,
                    height: 25.0,
                    child: FlatButton(
                      child: Text("Ir"),
                      splashColor: Colors.blue,
                      color: Colors.blueAccent,
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  List<Widget> _listFilms(List<Comunity> data) {
    List<Widget> films = [];
    for (var film in data) {
      films.add(Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Card(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  film.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.red),
                  textAlign: TextAlign.center,
                )),
            //Expanded(child: Image.network(film.urlImage, fit: BoxFit.fill)),
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
        )),
      ));
    }
    return films;
  }
}
