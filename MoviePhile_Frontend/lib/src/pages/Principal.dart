import 'package:flutter/material.dart';
import 'package:flutter_demo/src/providers/menu.dart';
import 'package:flutter_demo/src/utils/icono_string_util.dart';
import 'package:flutter_demo/src/pages/UserLogin_page.dart';

class Principal extends StatelessWidget {
  UserLogin_page page = new UserLogin_page();
  @override
  Widget build(BuildContext context) {
    return page;
  }

  /* Widget _buildBtnLogin(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      // width: double.minPositive,
      child: RaisedButton(
        child: Text('Login'),
        color: Colors.grey,
        textColor: Colors.black,
        shape: StadiumBorder(),
        onPressed: () {
          Navigator.pushNamed(context, 'User Login');
        },
        padding: EdgeInsets.all(15.0),
      ),
    );
  }

  Widget _buildSignupBtn(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      // width: double.minPositive,
      child: RaisedButton(
        child: Text('Sing Up'),
        color: Colors.grey,
        textColor: Colors.black,
        shape: StadiumBorder(),
        onPressed: () {
          Navigator.pushNamed(context, 'Registro Usuario');
        },
        padding: EdgeInsets.all(15.0),
      ),
    );
  }
*/
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
