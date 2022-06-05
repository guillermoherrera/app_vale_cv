import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../widgets/custom_snackbar.dart';

class CustomRequest {
  final secureStorage = const FlutterSecureStorage();
  final _customSnakBar = CustomSnackbar();

  Future<dynamic> request(url, body, model, context) async {
    dynamic respuesta;
    String url_refresh_token =
        'https://kc.fconfia.com/realms/SistemaCV/protocol/openid-connect/token';
    String refreshToken = await secureStorage.read(key: 'refresh_token');
    String productoID = await secureStorage.read(key: 'ProductoId');

    final response = await http.post(
      Uri.parse(url_refresh_token),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        "client_id": "uicv",
        "client_secret": "",
        "grant_type": "refresh_token",
        "refresh_token": refreshToken
      },
    );

    if (response.statusCode == 200) {
      final body2 = json.decode(response.body);
      String tokenActualizado = body2['access_token'];
      String tokenAntes = await secureStorage.read(key: 'access_token');
      log('TOKEN ANTES');
      log(tokenAntes);
      log('TOKEN DESPUES');
      log(tokenActualizado);
      secureStorage.write(key: 'access_token', value: tokenActualizado);
      String token = await secureStorage.read(key: 'access_token');
      String productoID = await secureStorage.read(key: 'ProductoId');
      String empresaId = await secureStorage.read(key: 'empresaId');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'EmpresaId': empresaId,
        'ProductoID': productoID, //<<<----OBTENER DEL LOGIN,
        'UUID': '', //<<<----OBTENER DEL LOGIN,
        'Authorization': 'Bearer $token',
      };
      debugPrint('$url - $body - $model - $headers');
      await http.post(url, headers: headers, body: body).then((value) {
        final decodeData = json.decode(value.body);
        if (decodeData['resultCode'] != 0) throw (decodeData['resultDesc']);
        respuesta = model.fromJson(decodeData['data']);
      }).catchError((e) {
        respuesta = model;
        ScaffoldMessenger.of(context).showSnackBar(_customSnakBar.error(
            msj: 'REQUEST ERROR: (${url.path}) $e.\n\n',
            time: const Duration(seconds: 8)));
        if ('$e'.contains('TokenExpired')) debugPrint('☠ ☠ ☠ LOGOUT ☠ ☠ ☠ ');
      }).timeout(const Duration(seconds: 60), onTimeout: () {
        respuesta = model;
        ScaffoldMessenger.of(context).showSnackBar(_customSnakBar.error(
            msj: 'REQUEST ERROR: TIEMPO DE ESPERA AGOTADO PARA LA SOLICITUD',
            time: const Duration(seconds: 8)));
      });
      return respuesta;
    } else {
      respuesta = model;
      ScaffoldMessenger.of(context).showSnackBar(_customSnakBar.error(
          msj: 'REQUEST ERROR: NO SE PUDO RENOVAR EL TOKEN',
          time: const Duration(seconds: 8)));
    }
  }

  Future<dynamic> requestBORRAR(url, body, model, context) async {
    dynamic respuesta;
    String token = await secureStorage.read(key: 'access_token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'ProductoID': '1' //<<<----OBTENER DEL LOGIN
    };
    await http.post(url, headers: headers, body: body).then((value) {
      final decodeData = json.decode(value.body);
      if (decodeData['resultCode'] != 1) throw (decodeData['msj']);
      respuesta = model.fromJson(decodeData['data']);
    }).catchError((e) {
      respuesta = model;
      ScaffoldMessenger.of(context).showSnackBar(_customSnakBar.error(
          msj: 'REQUEST ERROR: (${url.path}) $e.\n\n',
          time: const Duration(seconds: 8)));
      if ('$e'.contains('TokenExpired')) debugPrint('☠ ☠ ☠ LOGOUT ☠ ☠ ☠ ');
    }).timeout(const Duration(seconds: 15));
    return respuesta;
  }
}
