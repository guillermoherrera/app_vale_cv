import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/custom_snackbar.dart';

class Utilerias {
  final _customSnakBar = CustomSnackbar();

  checkCurp(BuildContext context, String curp) {
    int validacionCode = -1;
    List<String> _sexo = <String>['M', 'H'];
    List<String> _entidadesF = <String>[
      'AS',
      'BC',
      'BS',
      'CC',
      'CL',
      'CM',
      'CS',
      'CH',
      'DF',
      'DG',
      'GT',
      'GR',
      'HG',
      'JC',
      'MC',
      'MN',
      'MS',
      'NT',
      'NL',
      'OC',
      'PL',
      'QT',
      'QR',
      'SP',
      'SL',
      'SR',
      'TC',
      'TS',
      'TL',
      'VZ',
      'YN',
      'ZS',
      'NE'
    ];

    if (isNumeric(curp[0])) validacionCode = 0;
    if (isNumeric(curp[1])) validacionCode = 1;
    if (isNumeric(curp[2])) validacionCode = 2;
    if (isNumeric(curp[3])) validacionCode = 3;
    if (!isNumeric(curp[4])) validacionCode = 4;
    if (!isNumeric(curp[5])) validacionCode = 5;
    if (!isNumeric(curp[6])) validacionCode = 6;
    if (!isNumeric(curp[7])) validacionCode = 7;
    if (!isNumeric(curp[8])) validacionCode = 8;
    if (!isNumeric(curp[9])) validacionCode = 9;
    if (!_sexo.contains(curp[10])) validacionCode = 10;
    if (!_entidadesF.contains(curp.substring(11, 13))) validacionCode = 11;
    if (isNumeric(curp[13])) validacionCode = 13;
    if (isNumeric(curp[14])) validacionCode = 14;
    if (isNumeric(curp[15])) validacionCode = 15;

    if (validacionCode > -1) {
      SnackBar snackBar = _customSnakBar.error(
          msj: 'ERROR ($validacionCode): FORMATO DE LA CURP',
          icon: Icons.error);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }

    return true;
  }

  bool isNumeric(String string) {
    // ignore: unnecessary_null_comparison
    if (string == null || string.isEmpty) {
      return false;
    }

    final number = num.tryParse(string);

    if (number == null) {
      return false;
    }

    return true;
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
