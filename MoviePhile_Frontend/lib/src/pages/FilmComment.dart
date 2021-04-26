import 'package:flutter/material.dart';
import 'package:flutter_demo/src/services/FilmCommentService.dart';
import 'package:flutter_demo/src/utils/TextApp.dart';
import 'package:overlay_support/overlay_support.dart';

class CommentFilm extends StatefulWidget {
  @override
  _CommentFilmState createState() => _CommentFilmState();
}

enum options { COMMENT, THEORIES, EASTEREGGS }

class _CommentFilmState extends State<CommentFilm> {
  List<String> _lista = <String>[
    'Muy buena pelicula deberia de haber otra igual',
    'excelente pelicula',
    'Gracias a disney por realizar tan maravillosa pelicula ',
    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt.'
  ];
  @override
  Widget build(BuildContext context) {
    final _comentario = TextEditingController(text: "vacio");
    String _optionSelectString = "COMMENT";
    String userID = "0a92d309-7651-46df-bd7e-f9a9a51fe3be";
    var _lista2;

    Future<void> _allcommentGet() async {
      _lista2 = await filmcommentService.allCommentGet(399566);
      print(_lista2);
    }

    //_allcommentGet();

    void _setOptionSelectedValue(String ValuesS) {
      setState(() {
        _optionSelectString = ValuesS;
      });
    }

    Future<void> _showDialog() async {
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
                    final String registro = await filmcommentService
                        .filmCommentSend(_comentario.text, userID, 399566, 0);
                    toast(TextApp.COMMENT_MADE);
                    _lista.add(_comentario.text);
                  },
                ),
                SimpleDialogOption(
                  child: Text(
                    "Teorías",
                    style: TextStyle(color: Colors.white70),
                  ),
                  onPressed: () async {
                    Navigator.pop(context, options.THEORIES);
                    final String registro = await filmcommentService
                        .filmCommentSend(_comentario.text, userID, 399566, 1);
                    toast(TextApp.COMMENT_MADE);
                    _lista.add(_comentario.text);
                  },
                ),
                SimpleDialogOption(
                  child: Text(
                    "Huevos",
                    style: TextStyle(color: Colors.white70),
                  ),
                  onPressed: () async {
                    Navigator.pop(context, options.EASTEREGGS);
                    final String registro = await filmcommentService
                        .filmCommentSend(_comentario.text, userID, 399566, 2);
                    _lista.add(_comentario.text);

                    toast(TextApp.COMMENT_MADE);
                  },
                )
              ],
            );
          })) {
        case options.COMMENT:
          _setOptionSelectedValue('YES');
          break;

        case options.THEORIES:
          _setOptionSelectedValue('NO');
          break;

        case options.EASTEREGGS:
          _setOptionSelectedValue('MAYBE');
          break;

        default:
          break;
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("MoviePhile")),
        body: Container(
          color: Colors.grey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      "Godzilla vs Kong",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                          width: 200,
                          child: Image.network(
                              'https://image.tmdb.org/t/p/w500/pgqgaUx1cJb5oZQQ5v0tNARCeBp.jpg',
                              fit: BoxFit.fill)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "In a time when monsters walk the Earth, humanity’s fight for its future sets Godzilla and Kong on a collision course that will see the two most powerful forces of nature on the planet collide in a spectacular battle for the ages.",
                  ),
                ),
                Container(
                  height: 200,
                  child: SafeArea(
                    child: ListView.builder(
                        padding: EdgeInsets.all(10), //espaciado
                        scrollDirection: Axis
                            .vertical, //obligatorio declarar width para evitar error
                        //reverse: true,
                        itemCount: _lista.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Card(
                              child: ListTile(
                                subtitle: Text(
                                  'Sebastian Agudelo',
                                  textAlign: TextAlign.right,
                                ),
                                title: Text(_lista[index]),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  //height: 25,
                  //thickness: 2,
                  indent: 15,
                  endIndent: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        "Sebastian Agudelo",
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
                          hoverColor: Colors.white
                          //labelText: "Comentar",
                          /*errorText: ValidateDatos.isLastNameInvalid
                            ? TextApp.INVALID_LAST_NAME
                            : null,*/
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0, top: 0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        _showDialog();
                      },
                      child: Text('Comentar'),
                    ),
                  ),
                ),
                RaisedButton(onPressed: () {
                  var respon = filmcommentService.filmCommentSend(
                      "Comentario de la película", userID, 399566, 1);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
