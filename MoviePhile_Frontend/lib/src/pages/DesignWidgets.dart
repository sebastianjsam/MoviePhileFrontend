import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DesignWidgets {
  static LinearGradient linearGradientMain(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.blue,
        Theme.of(context).primaryColorLight,
        //Theme.of(context).primaryColorDark,
      ],
    );
  }

  //tittle custom
  //
  static RichText tittleCustom() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Movi',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [
            TextSpan(
                text: 'Phile',
                style: TextStyle(color: Colors.white, fontSize: 30))
          ]),
    );
  }

  static RichText tittleCustomDark() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'MoviePhile',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.grey,
          ),
          children: [
            TextSpan(
                text: 'List',
                style: TextStyle(color: Colors.black, fontSize: 30))
          ]),
    );
  }
}
