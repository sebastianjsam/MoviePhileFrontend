import 'package:flutter/material.dart';
import 'package:flutter_demo/src/Model/FilmS.dart';
import 'package:flutter_demo/src/Model/InfCommunity.dart';
import 'package:flutter_demo/src/Model/Publications.dart';
import 'package:flutter_demo/src/services/FilmCommentService.dart';
import 'package:flutter_demo/src/services/InfCommunity.dart';
import 'package:flutter_demo/src/services/addUserToCommunityService.dart';
import 'package:flutter_demo/src/utils/TextApp.dart';
import 'package:overlay_support/overlay_support.dart';

import 'menulateral.dart';

class InfCommunitys extends StatefulWidget {
  @override
  _InfCommunityState createState() => _InfCommunityState();
}

enum options { COMMENT, THEORIES, EASTEREGGS }
int fiml = 0;
int comunidadId = 0;
Future<bool> _seguirOrNot;

class _InfCommunityState extends State<InfCommunitys> {
  Future<InfComunity> _InfCommunity;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fiml = ModalRoute.of(context).settings.arguments;
      comunidadId = ModalRoute.of(context).settings.arguments;
      _seguirOrNot = serviceStatusUserCommunity(1);
      _InfCommunity = InfComunityService.GetInformationCommunityId(1);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context).settings.arguments);
    String userID = '';

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("MoviePhile")),
        // drawer: MenuLateral(),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: FutureBuilder<InfComunity>(
                future: _InfCommunity,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        _titleFilm(snapshot.data.name),
                        _descriptionFilm(snapshot.data.description),
                        _buttonJoinCommunity(userID),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Publicaciones",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: Colors.black54),
                                ),
                              ),
                              Column(
                                children: [
                                  ..._listPublication(
                                      snapshot.data.publications),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // _listInfPublication(snapshot.data.users),
                        // _dividerLine(),
                        // _boxComment(userID, _comentario),
                        //  _buttonCommentar(_comentario, userID)
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("error en la conexión");
                  }
                  return CircularProgressIndicator();
                }),
          ),
        ),
      ),
    );
  }

  Column _boxComment(userID, _comentario) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Text(
              "Comenta...",
              style: TextStyle(),
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: TextField(
            controller: _comentario,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              fillColor: Colors.white,
              focusColor: Colors.white,
              hoverColor: Colors.white,
            )),
      ),
    ]);
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
    String userID = "";
    final _comentario = TextEditingController(text: "");

    for (var publication in data) {
      films.add(Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Card(
            color: Colors.blueGrey[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      publication.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.blue),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        publication.content,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Comentarios: ",
                              textAlign: TextAlign.left,
                            )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              children: [
                                for (var c in publication.comments)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  c.user.email + ': ',
                                                  style: TextStyle(
                                                      color: Colors.blueAccent),
                                                ),
                                                Text(
                                                  c.content,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                Column(
                                  children: [
                                    _dividerLine(),
                                    _boxComment(userID,
                                        TextEditingController(text: "")),
                                    _buttonCommentar(_comentario, userID)
                                  ],
                                )
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              ],
            )),
      ));
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

  Widget _buttonJoinCommunity(userID) {
    return Container(); //ButtonJoinComunity();
  }

  ListView _commentScreen(comments) {
    return ListView.builder(
        padding: EdgeInsets.all(10), //espaciado
        scrollDirection:
            Axis.vertical, //obligatorio declarar width para evitar error
        //reverse: true,
        itemCount: comments?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Card(
              child: ListTile(
                subtitle: Text(
                  comments.cast<dynamic>()[index]['user']['email'].toString(),
                  textAlign: TextAlign.right,
                ),
                title:
                    Text(comments.cast<dynamic>()[index]['content'].toString()),
              ),
            ),
          );
        });
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
            child: Card(
              child: Row(
                children: [
                  Container(
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

  //----Si se logra cambiar mejor

}
