import 'package:flutter/material.dart';
import 'package:flutter_demo/src/Model/FilmS.dart';
import 'package:flutter_demo/src/Model/InfCommunity.dart';
import 'package:flutter_demo/src/Model/Publications.dart';
import 'package:flutter_demo/src/services/FilmCommentService.dart';
import 'package:flutter_demo/src/services/InfCommunity.dart';
import 'package:flutter_demo/src/utils/TextApp.dart';
import 'package:overlay_support/overlay_support.dart';

import 'menulateral.dart';

class InfCommunitys extends StatefulWidget {
  @override
  _InfCommunityState createState() => _InfCommunityState();
}

enum options { COMMENT, THEORIES, EASTEREGGS }
int fiml = 0;

class _InfCommunityState extends State<InfCommunitys> {
  Future<InfComunity> _InfCommunity;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fiml = ModalRoute.of(context).settings.arguments;
      _InfCommunity = InfComunityService.GetInformationCommunityId(3);
      setState(() {});
    });
  }

  @override
  void didInitState() {}

  @override
  Widget build(BuildContext context) {
    String userID = "";
    final _comentario = TextEditingController(text: "");
    print(ModalRoute.of(context).settings.arguments);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("MoviePhile")),
        // drawer: MenuLateral(),
        body: Container(
          color: Colors.grey,
          child: SingleChildScrollView(
            child: FutureBuilder<InfComunity>(
                future: _InfCommunity,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        _titleFilm(snapshot.data.name),
                        _descriptionFilm(snapshot.data.description),
                        // _listInfPublication(snapshot.data.users),

                        _dividerLine(),
                        // _boxComment(userID, _comentario),
                        //  _buttonCommentar(_comentario, userID)
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("error en la conexión");
                  }
                }),
          ),
        ),
      ),
    );
  }

  Padding _titleFilm(title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Container _descriptionFilm(text) {
    return Container(padding: EdgeInsets.all(10), child: Text(text));
  }

  Divider _dividerLine() {
    return Divider(
      color: Colors.grey,
      //height: 25,
      //thickness: 2,
      indent: 15,
      endIndent: 15,
    );
  }

  List<Widget> _listPublication(List<Publications> data) {
    List<Widget> films = [];
    for (var publication in data) {
      films.add(Card(
          child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text(
                publication.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.red),
                textAlign: TextAlign.center,
              )),
        ],
      )));
    }
    return films;
  }

  Padding _buttonCommentar(_comentario, userID) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, top: 0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          onPressed: () {},
          child: Text(TextApp.COMMENT_TEXT),
        ),
      ),
    );
  }

  ListView _listInfPublication(snapshot) {
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
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            snapshot.data[index].userName.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
