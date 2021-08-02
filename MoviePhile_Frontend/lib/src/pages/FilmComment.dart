import 'package:flutter/material.dart';
import 'package:flutter_demo/src/Model/FilmS.dart';
import 'package:flutter_demo/src/services/FilmCommentService.dart';
import 'package:flutter_demo/src/services/RecordfilmratingService.dart';
import 'package:flutter_demo/src/utils/TextApp.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:overlay_support/overlay_support.dart';

import 'menulateral.dart';

class CommentFilm extends StatefulWidget {
  @override
  _CommentFilmState createState() => _CommentFilmState();
}

enum options { COMMENT, THEORIES, EASTEREGGS }
int fiml = 0;

class _CommentFilmState extends State<CommentFilm> {
  Future<FilmS> _filcomentList;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fiml = ModalRoute.of(context).settings.arguments;
      _filcomentList = FilmcommentService.allCommentGetFilm(fiml);
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
            child: FutureBuilder<FilmS>(
                future: _filcomentList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        _titleFilmDecorado(snapshot.data.title),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _imgFilm(snapshot),
                            _calificacion(snapshot)
                          ],
                        ),
                        _dividerLine(),
                        _rating(fiml),
                        _dividerLine(),
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

  Text _calificacion(snapshot) {
    return Text(snapshot.data.score.toStringAsFixed(1),
        style: TextStyle(color: Colors.black, fontSize: 50));
  }

  Row _rating(int filmId) {
    return Row(
      children: [
        Text(
          "Calificar: ",
          style: TextStyle(
              color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Expanded(
            child: RatingBar.builder(
          itemCount: 5,
          initialRating: 3.4,
          itemBuilder: (context, int index) {
            return Icon(Icons.star, color: Colors.amber);
          },
          onRatingUpdate: (double value) {
            print("valor de estrellas: " + value.toString());
            //llamamos al servicio
            RecordfilmratingService.Recordfilmrating2(value.toInt(), filmId);

            WidgetsBinding.instance.addPostFrameCallback((_) {
              fiml = ModalRoute.of(context).settings.arguments;
              _filcomentList = FilmcommentService.allCommentGetFilm(fiml);
              setState(() {});
            });
          },
        )),
      ],
    );
  }

  Container _titleFilmDecorado(title) {
    return Container(
      child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            title,
            style: TextStyle(
              fontSize: 40,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 6
                ..color = Colors.blue[700],
            ),
          ),
          // Solid text as fill.
          Text(
            title,
            style: TextStyle(
              fontSize: 40,
              color: Colors.grey[300],
            ),
          ),
        ],
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
              //labelText: "Comentar",
              /*errorText: ValidateDatos.isLastNameInvalid
                            ? TextApp.INVALID_LAST_NAME
                            : null,*/
            )),
      ),
    ]);
  }

  void succesfullComment(registro) {
    //print("registro: " + registro);

    if (registro.contains("true")) {
      toast(TextApp.COMMENT_MADE);
      //falta agregar el comentario sin tener que consultar a la base de datos.
      _filcomentList = FilmcommentService.allCommentGetFilm(fiml);
      //fin
      setState(() {});
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
                  String registro = await FilmcommentService.filmCommentSend(
                      _comentario.text, userID, fiml, 0);

                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    succesfullComment(await registro);
                    setState(() {});
                  });
                },
              ),
              SimpleDialogOption(
                child: Text(
                  "Teorías",
                  style: TextStyle(color: Colors.white70),
                ),
                onPressed: () async {
                  Navigator.pop(context, options.THEORIES);
                  String registro = await FilmcommentService.filmCommentSend(
                      _comentario.text, userID, fiml, 1);
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
                  String registro = await FilmcommentService.filmCommentSend(
                      _comentario.text, userID, fiml, 2);
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
