import 'package:flutter/material.dart';
import 'package:flutter_demo/src/Model/FilmS.dart';
import 'package:flutter_demo/src/services/FilmCommentService.dart';
import 'package:flutter_demo/src/utils/TextApp.dart';
import 'package:overlay_support/overlay_support.dart';

class CommentFilm extends StatefulWidget {
  @override
  _CommentFilmState createState() => _CommentFilmState();
}

enum options { COMMENT, THEORIES, EASTEREGGS }

class _CommentFilmState extends State<CommentFilm> {
  Future<FilmS> _filcomentList;
  @override
  void initState() {
    super.initState();
    _filcomentList = FilmcommentService.allCommentGetFilm(399566);
  }

  @override
  Widget build(BuildContext context) {
    String userID = "0a92d309-7651-46df-bd7e-f9a9a51fe3be";
    final _comentario = TextEditingController(text: "vacio");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("MoviePhile")),
        body: Container(
          color: Colors.grey,
          child: SingleChildScrollView(
            child: FutureBuilder<FilmS>(
                future: _filcomentList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        _titleFilm(snapshot.data.title),
                        _imgFilm(snapshot),
                        _descriptionFilm(snapshot.data.overView.toString()),
                        Container(
                          height: snapshot.data.comments.length == 0 ? 0 : 200,
                          child: SafeArea(child: _commentScreen(snapshot)),
                        ),
                        _dividerLine(),
                        _boxComment(userID, _comentario),
                        _buttonCommentar(_comentario, userID)
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
          ),
        ),
      ),
    );
  }

  ListView _commentScreen(snapshot) {
    return ListView.builder(
        padding: EdgeInsets.all(10), //espaciado
        scrollDirection:
            Axis.vertical, //obligatorio declarar width para evitar error
        //reverse: true,
        itemCount: snapshot.data.comments.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Card(
              child: ListTile(
                subtitle: Text(
                  snapshot.data.comments
                      .cast<dynamic>()[index]['user']['email']
                      .toString(),
                  textAlign: TextAlign.right,
                ),
                title: Text(snapshot.data.comments
                    .cast<dynamic>()[index]['content']
                    .toString()),
              ),
            ),
          );
        });
  }

  Container _imgFilm(snapshot) {
    return Container(
        width: 200,
        child: Image.network(snapshot.data.homePage + snapshot.data.posterPath,
            fit: BoxFit.fill));
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

  Column _boxComment(userID, _comentario) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Text(
              userID,
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
              //labelText: "Comentar",
              /*errorText: ValidateDatos.isLastNameInvalid
                            ? TextApp.INVALID_LAST_NAME
                            : null,*/
            )),
      ),
    ]);
  }

  void succesfullComment(registro) {
    print("registro: " + registro);
    if (registro.contains("true")) {
      toast(TextApp.COMMENT_MADE);
      //falta agregar el comentario sin tener que consultar a la base de datos.
      //
      //fin
    }
  }

  Future<void> _showDialog(_comentario, userID) async {
    switch (await showDialog<options>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            titlePadding: EdgeInsets.all(10),
            backgroundColor: Colors.grey,
            title: Text(
              'Seleciona el Tipo:',
              style: TextStyle(color: Colors.white),
            ),
            children: [
              SimpleDialogOption(
                child: Text(
                  "Comentario",
                  style: TextStyle(color: Colors.white70),
                ),
                onPressed: () async {
                  Navigator.pop(context, options.COMMENT);
                  final String registro =
                      await FilmcommentService.filmCommentSend(
                          _comentario.text, userID, 399566, 0);

                  succesfullComment(registro);
                },
              ),
              SimpleDialogOption(
                child: Text(
                  "Teorías",
                  style: TextStyle(color: Colors.white70),
                ),
                onPressed: () async {
                  Navigator.pop(context, options.THEORIES);
                  final String registro =
                      await FilmcommentService.filmCommentSend(
                          _comentario.text, userID, 399566, 1);
                  succesfullComment(registro);
                  //falta agregar el comentario sin tener que consultar a la base de datos.
                  //
                  //fin
                },
              ),
              SimpleDialogOption(
                child: Text(
                  "Huevos",
                  style: TextStyle(color: Colors.white70),
                ),
                onPressed: () async {
                  Navigator.pop(context, options.EASTEREGGS);
                  final String registro =
                      await FilmcommentService.filmCommentSend(
                          _comentario.text, userID, 399566, 2);
                  succesfullComment(registro);
                },
              )
            ],
          );
        })) {
      case options.COMMENT:
        break;
      case options.THEORIES:
        break;
      case options.EASTEREGGS:
        break;
    }
  }

  Padding _buttonCommentar(_comentario, userID) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, top: 0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          onPressed: () {
            _showDialog(_comentario, userID);
          },
          child: Text(TextApp.COMMENT_TEXT),
        ),
      ),
    );
  }
}
