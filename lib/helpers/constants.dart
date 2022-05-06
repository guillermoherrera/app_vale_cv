import 'package:flutter/material.dart';

class Constants {
  //Colors
  static const Color colorPrimary = Color(0xff75BD23);
  static const Color colorSecondary = Color(0xff04448C);
  static const Color colorAlternative = Color(0xff357FB7);
  static const Color colorDefault = Color(0xffDFEEDF);
  static const Color colorDefaultText = Color(0xff3B5F11);

  //Rutas
  static const String pageRoot = 'root';

  //Assets
  static const String assetsImagelogo = 'assets/logoConfia.png';
  static const String assetsFondologin = 'assets/fondoLogin.jpg';

  //TextStyle
  static const TextStyle textStyleHeader = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 40.0, color: colorDefaultText);
  static const TextStyle textStyleTitle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 30.0, color: colorDefaultText);
  static const TextStyle textStyleSubTitle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 18.0, color: colorDefaultText);
  static const TextStyle textStyleParagraph = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 10.0, color: colorDefaultText);

  static const TextStyle textStyleHeaderDefault = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 40.0, color: colorDefault);
  static const TextStyle textStyleTitleDefault = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 30.0, color: colorDefault);
  static const TextStyle textStyleSubTitleDefault = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 18.0, color: colorDefault);
  static const TextStyle textStyleParagraphDefault = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 10.0, color: colorDefault);
}
