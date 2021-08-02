import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/Model/Comunity.dart';
import 'package:flutter_demo/src/pages/InfCommunity.dart';
import 'package:flutter_demo/src/services/ConsultComunityService.dart';

import 'menulateral.dart';

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
          drawer: MenuLateral(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder<List<Comunity>>(
                  future: _listadoFilms,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        //mainAxisSize: MainAxisSize.min,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              child: Text(
                            "Comunidades",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                          SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Container(
                              //height: MediaQuery.of(context).size.height,
                              child: _listComunity(snapshot),
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        "error",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      );
                    }
                    return Center(
                      heightFactor: 15,
                      child: Container(
                        //height: MediaQuery.of(context).size.height / 2,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 6,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }

  ListView _listComunity(snapshot) {
    return ListView.builder(
        padding: EdgeInsets.all(10), //espaciado
        scrollDirection:
            Axis.vertical, //obligatorio declarar width para evitar error
        //reverse: true,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new InfCommunitys()));
                        /* Navigator.pushNamed(context, "InfCommunity",
                            arguments: 1);
*/
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
