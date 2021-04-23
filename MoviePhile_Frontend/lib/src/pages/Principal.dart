import 'package:flutter/material.dart';
import 'package:flutter_demo/src/providers/menu.dart';
import 'package:flutter_demo/src/utils/icono_string_util.dart';

class Principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: _lista(),
    );
  }

  Widget _lista() {
    return FutureBuilder(
      future: menuProvider.cargarDatos(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _listaItems(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];

    data.forEach((opt) {
      final widgetTem = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.green),
        onTap: () {
          /* final route = MaterialPageRoute(builder: (context) {
            return AlertPage();
          });
          Navigator.push(context, route);*/
          Navigator.pushNamed(context, opt['ruta']);
        },
      );
      opciones..add(widgetTem)..add(Divider());
    });
    return opciones;
  }
}
