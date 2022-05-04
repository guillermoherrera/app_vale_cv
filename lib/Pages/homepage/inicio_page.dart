import 'package:flutter/material.dart';

import '../../helpers/constants.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'INICIO',
      style: Constants.textStyleSubTitle,
    );
  }
}
