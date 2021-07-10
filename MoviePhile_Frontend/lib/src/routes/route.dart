import 'package:flutter/material.dart';
import 'package:flutter_demo/src/pages/ConsultCommunity.dart';
import 'package:flutter_demo/src/pages/FilmComment.dart';
import 'package:flutter_demo/src/pages/LoginUsuario_page.dart';
import 'package:flutter_demo/src/pages/Principal.dart';
import 'package:flutter_demo/src/pages/Registro_page.dart';
import 'package:flutter_demo/src/pages/ConsultarTitulo_page.dart';

Map<String, WidgetBuilder> getObtenerRutas() {
  return <String, WidgetBuilder>{
    //Rutas a las cuales estan creadas y que podemos acceder
    '/': (BuildContext context) => Principal(),
    'login Usuario': (BuildContext context) => LoginUsuarioPage(),
    'Registro Usuario': (BuildContext context) => RegistroPage(),
    'Search Title': (BuildContext context) => SearchPage(),


    'CommentFilm': (BuildContext context) => CommentFilm(),

    'Consultar Titulo': (BuildContext context) => ConsultarPage(),

    'ConsultComunity': (BuildContext context) => ConsultComunityPage(),
  };
}
