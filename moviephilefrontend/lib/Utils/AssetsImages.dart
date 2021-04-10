import 'package:flutter/material.dart';

class AssetsImages {
  static final String path = "assets/images/";

  static Image Imagenlauncher() {
    return Image.asset("${path}ic_launcher.png");
  }

  static Image ImagenLogo() {
    return Image.asset("${path}LogoShoppingList.png");
  }
}
