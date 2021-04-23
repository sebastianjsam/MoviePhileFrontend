import 'package:flutter/material.dart';
import 'package:flutter_demo/src/pages/Principal.dart';
//import 'package:flutter_demo/src/pages/alert_page.dart';

import 'package:flutter_demo/src/routes/route.dart';
//import 'package:flutter_demo/src/pages/home_temp.dart';

void main() => runApp(MyApp());

//main principal
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      // home: HomePage()
      initialRoute: '/',
      routes: getObtenerRutas(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => Principal());
      },
    );
  }
}
