import 'package:flutter/material.dart';
import 'package:flutter_demo/src/Model/Film.dart';
import 'package:flutter_demo/src/Model/User_Login.dart';
import 'package:flutter_demo/src/pages/ConsultCommunity.dart';
import 'package:flutter_demo/src/pages/FilmComment.dart';
import 'package:flutter_demo/src/pages/Registrar_Comunidad.dart';
import 'package:flutter_demo/src/pages/UserLogin_page.dart';
import 'package:flutter_demo/src/services/SearchTitle_service.dart';

import 'ConsultarTitulo_page.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text("MoviePhile"),
            accountEmail: Text("MoviePhile@gmail.com"),
          ),
          Ink(
            color: Colors.indigo,
            child: new ListTile(
                title: Text(
                  "Buscar Titulo",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new SearchPage(),
                    ),
                  );
                }),
          ),
          new ListTile(
            title: Text("Registrar Comunidad"),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new Registrar_Comunidad(),
                ),
              );
            },
          ),
          new ListTile(
            title: Text("Consultar Comunidad"),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new ConsultComunityPage(),
                ),
              );
            },
          ),
          new ListTile(
            title: Text("Salir"),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new CommentFilm(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
