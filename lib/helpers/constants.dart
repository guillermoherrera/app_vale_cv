import 'package:flutter/material.dart';

class Constants {
  //Colors
  // static const Color colorPrimary = Colors.grey;
  // static const Color colorSecondary = Colors.grey;
  // static const Color colorAlternative = Colors.black;
  // static const Color colorDefault = Colors.white;
  // static const Color colorDefaultText = Colors.black;

  // static const Color colorPrimary = Color(0xff75BD23);
  // static const Color colorSecondary = Color(0xff04448C);
  // static const Color colorAlternative = Color(0xff357FB7);
  // static const Color colorDefault = Color(0xffDFEEDF);
  // static const Color colorDefaultText = Color(0xff3B5F11);

  static const Color colorPrimary = Color(0xff0C0C7C);
  static const Color colorSecondary = Color(0xff1BA2FA);
  static const Color colorAlternative = Color(0xffE652BA);
  static const Color colorDefault = Color(0xffDFDFEE);
  static const Color colorDefaultText = Color(0xff1BA2FA);

  //Rutas
  static const String pageRoot = 'root';
  static const String pageCliente = 'cliente';
  static const String pageVale = 'vale';
  static const String pageClientesVale = 'clientesVale';
  static const String pageDesembolso = 'desembolso';
  static const String pagePlazos = 'plazo';
  static const String pageDestinos = 'destino';
  static const String pageHistorial = 'historial';
  static const String pageCodigo = 'codigo';
  static const String pageNuevoCliente = 'nuevoCliente';
  static const String pageActivacion = 'activardv';

  //Assets
  static const String assetsImagelogo = 'assets/logoConfia.png';
  static const String assetsImagelogo2 = 'assets/logoPrestaStar.png';
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

  //API
  static const apiBase = 'apicv.fconfia.com';
  static const apiDvinfo = 'api/AppVale/AppDistribuidores/get';
  static const apiDvLineas = 'api/AppVale/AppDistribuidores/getlineas';
  static const apiClientes = 'api/AppVale/AppClientes/get';
  static const apiVales = 'api/AppVale/AppCreditos/get';
  static const apiValesDetalle = 'api/AppVale/AppCreditos/gedetalle';
  static const apiDvSaldos = 'api/AppVale/AppDistribuidores/getsaldorelacion';
  static const apiHistorialCliente = 'api/AppVale/AppClientes/getsingle';
  static const apiDesembolsos = 'api/AppVale/AppCatalogos/getdesembolsos';
  static const apiPlazosImporte = 'api/AppVale/AppCreditos/getplazos';
  static const apiDestinos = 'api/AppVale/AppCatalogos/getdestinos';
  static const apiSolicitar = 'api/AppVale/AppCreditos/canjevaleapp';
  static const apiEnviarSms = 'api/AppVale/AppCreditos/enviarcodigocliente';
  static const apiconfirmarCodigo = 'api/AppVale/AppCreditos/verificarcodigo';
  static const apiClienteXCurp = 'api/AppVale/AppClientes/buscaPersona';
  static const apiAsentamientos = 'api/AppVale/AppCatalogos/getdireccionbycp';
}
