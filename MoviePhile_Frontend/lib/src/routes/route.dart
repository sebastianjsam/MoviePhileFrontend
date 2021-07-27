import 'package:flutter/material.dart';
import 'package:flutter_demo/src/pages/AgregarUsuarioAComunidad.dart';
import 'package:flutter_demo/src/pages/ConsultCommunity.dart';
import 'package:flutter_demo/src/pages/FilmComment.dart';
import 'package:flutter_demo/src/pages/InfCommunity.dart';
import 'package:flutter_demo/src/pages/PostInCommunity.dart';
import 'package:flutter_demo/src/pages/UserLogin_page.dart';
import 'package:flutter_demo/src/pages/Principal.dart';
import 'package:flutter_demo/src/pages/Registro_page.dart';
import 'package:flutter_demo/src/pages/ConsultarTitulo_page.dart';
import 'package:flutter_demo/src/pages/Registrar_Comunidad.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    //Rutas a las cuales estan creadas y que podemos acceder
    '/': (BuildContext context) => Principal(),
    'User Login': (BuildContext context) => UserLogin_page(),
    'Registro Usuario': (BuildContext context) => RegistroPage(),
    'Search Title': (BuildContext context) => SearchPage(),

    'Registrar Comunidad': (BuildContext context) => Registrar_Comunidad(),

    'CommentFilm': (BuildContext context) => CommentFilm(),

    'Consultar Titulo': (BuildContext context) => SearchPage(),

    'ConsultComunity': (BuildContext context) => ConsultComunityPage(),

    'PostInCommunity': (BuildContext context) => PostInCommunity(),


    'InfCommunity': (BuildContext context) => InfCommunitys(),

    'addUserToCommunity': (BuildContext context) => AddUsertToComunity(),
  };
}
