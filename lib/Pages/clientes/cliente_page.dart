import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../widgets/custom_app_bar.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({Key? key}) : super(key: key);

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Constants.colorPrimary,
      body: _body(),
    );
  }

  PreferredSize _appBar() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: CustomAppBar(),
    );
  }

  Widget _body() {
    return Column(
      children: [_encabezado(), _resumen()],
    );
  }

  Widget _encabezado() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            child: const Icon(Icons.person,
                color: Constants.colorPrimary, size: 100),
            decoration: const BoxDecoration(
                color: Colors.black, shape: BoxShape.circle),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: const Text(
              'NOMBRE CLIENTE',
              style: Constants.textStyleSubTitleDefault,
            ),
          )
        ],
      ),
    );
  }

  Widget _resumen() {
    return Expanded(
        child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            color: Constants.colorDefault,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_datos(), _historial()],
            )));
  }

  Widget _datos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('DATOS DE CONTACTO', style: Constants.textStyleSubTitle),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Table(
            children: const [
              TableRow(children: [
                Text('TELEFONO:', style: Constants.textStyleStandard),
                Align(
                    alignment: Alignment.centerRight,
                    child:
                        Text('871-1223344', style: Constants.textStyleStandard))
              ]),
              TableRow(children: [
                Text('DIRECCIÓN:', style: Constants.textStyleStandard),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        'TAMAZULA #393 PARQUE INDUSTRIAL 35078 GOMEZ PALACIO, DURANGO',
                        style: Constants.textStyleStandard,
                        textAlign: TextAlign.end))
              ])
            ],
          ),
        )
      ],
    );
  }

  Widget _historial() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('HISTORIAL DE PAGOS', style: Constants.textStyleSubTitle),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Table(
            children: const [
              TableRow(children: [
                Align(
                    alignment: Alignment.center,
                    child:
                        Text('# DE VALE', style: Constants.textStyleSubTitle)),
                Align(
                    alignment: Alignment.center,
                    child: Text('IMPORTE', style: Constants.textStyleSubTitle)),
                Align(
                    alignment: Alignment.center,
                    child: Text('ESTADO', style: Constants.textStyleSubTitle))
              ]),
              TableRow(children: [
                Text('#000000002', style: Constants.textStyleStandard),
                Align(
                    alignment: Alignment.centerRight,
                    child:
                        Text('\$1000.00', style: Constants.textStyleStandard)),
                Align(
                    alignment: Alignment.center,
                    child: Text('ACTIVO', style: Constants.textStyleStandard)),
              ]),
              TableRow(children: [
                Text('#000000001', style: Constants.textStyleStandard),
                Align(
                    alignment: Alignment.centerRight,
                    child:
                        Text('\$1000.00', style: Constants.textStyleStandard)),
                Align(
                    alignment: Alignment.center,
                    child: Text('INACTIVO',
                        style: Constants.textStyleStandardError)),
              ])
            ],
          ),
        )
      ],
    );
  }
}
