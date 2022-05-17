import 'package:flutter/material.dart';

class Constants {
  //Colors
  // static const Color colorPrimary = Colors.grey;
  // static const Color colorSecondary = Colors.grey;
  // static const Color colorAlternative = Colors.black;
  // static const Color colorDefault = Colors.white;
  // static const Color colorDefaultText = Colors.black;

  static const Color colorPrimary = Color(0xff75BD23);
  static const Color colorSecondary = Color(0xff04448C);
  static const Color colorAlternative = Color(0xff357FB7);
  static const Color colorDefault = Color(0xffDFEEDF);
  static const Color colorDefaultText = Color(0xff3B5F11);

  //Rutas
  static const String pageRoot = 'root';
  static const String pageCliente = 'cliente';
  static const String pageVale = 'vale';
  static const String pageClientesVale = 'clientesVale';
  static const String pageDesembolso = 'desembolso';
  static const String pagePlazos = 'plazo';
  static const String pageDestinos = 'destino';

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
  static const TextStyle textStyleStandard = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 12.0, color: colorDefaultText);
  static const TextStyle textStyleStandardError =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: Colors.red);
  static const TextStyle textStyleParagraph = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 10.0, color: colorDefaultText);
  static const TextStyle textStyleParagraphError =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: Colors.red);

  static const TextStyle textStyleHeaderDefault = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 40.0, color: colorDefault);
  static const TextStyle textStyleTitleDefault = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 30.0, color: colorDefault);
  static const TextStyle textStyleSubTitleDefault = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 18.0, color: colorDefault);
  static const TextStyle textStyleStandardDefault = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 12.0, color: colorDefault);
  static const TextStyle textStyleParagraphDefault = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 10.0, color: colorDefault);

  static const TextStyle textStyleHeaderAlternative = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 40.0, color: colorAlternative);
  static const TextStyle textStyleTitleAlternative = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 30.0, color: colorAlternative);
  static const TextStyle textStyleSubTitleAlternative = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 18.0, color: colorAlternative);
  static const TextStyle textStyleStandardAlternative = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 12.0, color: colorAlternative);
  static const TextStyle textStyleParagraphAlternative = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 10.0, color: colorAlternative);
}
