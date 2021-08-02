import 'package:flutter/material.dart';
import 'package:flutter_demo/src/services/PostInCommunityService.dart';
import 'package:flutter_demo/src/utils/TextApp.dart';
import 'package:overlay_support/overlay_support.dart';

import 'menulateral.dart';

class PostInCommunity extends StatefulWidget {
  @override
  _CommentFilmState createState() => _CommentFilmState();
}

enum options { COMMENT, THEORIES, EASTEREGGS }

class _CommentFilmState extends State<PostInCommunity> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _contentText = TextEditingController(text: "");
    final _titleText = TextEditingController(text: "");
    //parametros requeridos desde los detalles de la comunidad
    final _communitytId = 1;
    final _titleCommunityText = "Titulo de Comunidad";

    print(ModalRoute.of(context).settings.arguments);

    return SafeArea(
      child: Scaffold(
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
        drawer: MenuLateral(),
        body: Container(
          // color: Colors.grey,
          child: SingleChildScrollView(
              child: Column(
            children: [
              _titleCommunity(_titleCommunityText),
              _titleFilm("Crear una nueva publicación"),
              _dividerLine(),
              _dividerLine(),
              _setCreateTitle(_titleText),
              // _imgFilm(snapshot),
              //_descriptionFilm(snapshot.data.overView.toString()),
              //_dividerLine(),
              _boxComment(_contentText),
              _buttonPublish(_contentText, _titleText, _communitytId)
            ],
          )),
        ),
      ),
    );
  }

  Padding _titleFilm(title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding _titleCommunity(title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 5),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
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

  Column _boxComment(_comentario) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Text(
              "Contenido",
              style: TextStyle(),
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: TextField(
            maxLines: 10,
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

  void succesfullPublish(registro) {
    //print("registro: " + registro);
    try {
      if (registro.contains("true")) {
        toast(TextApp.PUBLISH_DONE);
        //falta agregar el comentario sin tener que consultar a la base de datos.
        //_filcomentList = FilmcommentService.allCommentGetFilm(fiml);
        //fin
        setState(() {});
      } else {
        toast(TextApp.PUBLISH_FAIL);
        setState(() {});
      }
    } catch (e) {
      toast("Error:" + TextApp.PUBLISH_FAIL);
      print("Error: " + registro);
      setState(() {});
    }
  }

  Future<void> _showDialog(_content, _titleText, _communitytId) async {
    String registro = await PostInCommunityService.postInCommunitySend(
        _content.text, _titleText.text, _communitytId);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      succesfullPublish(registro);
      setState(() {});
    });
  }

  Padding _buttonPublish(_comentario, _titleText, _commentId) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, top: 0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          onPressed: () {
            _showDialog(_comentario, _titleText, _commentId);
          },
          child: Text(TextApp.PUBLISH_TEXT),
        ),
      ),
    );
  }

  Column _setCreateTitle(_titleText) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(
                "Titulo",
                style: TextStyle(),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: TextField(
              controller: _titleText,
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
      ],
    );
  }
}
