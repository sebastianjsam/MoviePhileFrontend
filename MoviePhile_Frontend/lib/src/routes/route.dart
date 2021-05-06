import 'package:flutter/material.dart';
import 'package:flutter_demo/src/pages/FilmComment.dart';
import 'package:flutter_demo/src/pages/UserLogin_page.dart';
import 'package:flutter_demo/src/pages/Principal.dart';
import 'package:flutter_demo/src/pages/Registro_page.dart';
import 'package:flutter_demo/src/pages/ConsultarTitulo_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    //Rutas a las cuales estan creadas y que podemos acceder
    '/': (BuildContext context) => Principal(),
    'User Login': (BuildContext context) => UserLogin_page(),
    'Registro Usuario': (BuildContext context) => RegistroPage(),

    'CommentFilm': (BuildContext context) => CommentFilm(),

    'Consultar Titulo': (BuildContext context) => ConsultarPage(),
  };
}
