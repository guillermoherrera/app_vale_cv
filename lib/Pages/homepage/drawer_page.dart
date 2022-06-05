import 'package:app_vale_cv/bloc/dvInfo/dvinfo_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_vale_cv/pages/login/login_page.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

import 'package:app_vale_cv/helpers/constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/shake_transition.dart';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();
const auth0Logout =
    'https://kc.fconfia.com/realms/SistemaCV/ConfiaRestID/logout__token_id';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  Random random = Random();
  final _customSnakBar = CustomSnackbar();

  //Method to show alert notification
  void _showAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Aviso'),
          content: const Text('¿Está seguro que desea cerrar sesión?'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    //Alert with confirmation

    // final paramters = {
    //   'sub': '${await secureStorage.read(key: 'sub')}',
    //   'sid': '${await secureStorage.read(key: 'sid')}',
    // };
    final msg = jsonEncode({
      'sup': await secureStorage.read(key: 'sub'),
      'sid': await secureStorage.read(key: 'sid'),
    });

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post(
        Uri.parse(
          auth0Logout,
        ),
        body: msg,
        headers: headers);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      secureStorage.deleteAll();
      //Kill context and open LoginPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      //log(response.body.toString());
      if (mounted) {
        SnackBar snackBar = _customSnakBar.error(msj: 'Error al cerrar sesión');
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: _width * 1.0,
      child: Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: Constants.colorPrimary.withOpacity(0.7)),
        child: Drawer(
          child:
              BlocBuilder<DvinfoBloc, DvinfoState>(builder: (context, state) {
            return Column(children: _menu(_height, context, state));
          }),
        ),
      ),
    );
  }

  List<Widget> _menu(double height, BuildContext context, DvinfoState state) {
    return [_appBar(), _header(height, state), _body(state)];
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: CustomAppBar(actions: [
        Container(
            margin: const EdgeInsets.only(right: 10.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Constants.colorPrimary.withOpacity(0.7),
                boxShadow: [
                  BoxShadow(
                    color: Constants.colorDefaultText.withOpacity(0.7),
                    blurRadius: 10.0,
                  ),
                ]),
            child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => {Navigator.pop(context)}))
      ]),
    );
  }

  Widget _header(double height, DvinfoState state) {
    List<Widget> childrens = [
      ShakeTransition(
        duration: Duration(milliseconds: random.nextInt(3) * 1000),
        child: Container(
          child: const Icon(Icons.person,
              color: Constants.colorPrimary, size: 100),
          decoration: const BoxDecoration(
              color: Constants.colorDefault, shape: BoxShape.circle),
        ),
      ),
      ShakeTransition(
        duration: Duration(milliseconds: random.nextInt(3) * 1000),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Text(
              '${state.data?.primerNombre} ${state.data?.segundoNombre} ${state.data?.primerApellido} ${state.data?.segundoApellido}',
              style: Constants.textStyleSubTitleDefault,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
      ShakeTransition(
        duration: Duration(milliseconds: random.nextInt(3) * 1000),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Text(
              '${state.data?.infoSistema?.sistemaDesc}',
              style: Constants.textStyleStandardDefault,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      )
    ];

    return SizedBox(
      height: height / 3.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: childrens,
      ),
    );
  }

  Widget _body(DvinfoState state) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Container(
          color: Constants.colorDefault,
          child: _bodyContent(state),
        ),
      ),
    );
  }

  Widget _bodyContent(DvinfoState state) {
    return Column(
      children: [Expanded(child: _info(state)), _button()],
    );
  }

  Widget _info(DvinfoState state) {
    return Column(
      children: [
        ShakeTransition(
          duration: Duration(milliseconds: random.nextInt(3) * 1000),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            child: const Text(
              'DATOS PERSONALES',
              style: Constants.textStyleSubTitle,
            ),
          ),
        ),
        ShakeTransition(
          duration: Duration(milliseconds: random.nextInt(3) * 1000),
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Table(children: [
              _tableRow(
                  const Text('NUMERO DE SOCIA DV',
                      overflow: TextOverflow.ellipsis,
                      style: Constants.textStyleStandard),
                  Text('#${state.data?.distribuidorId}',
                      style: Constants.textStyleStandard)),
              // ignore: prefer_is_empty
              state.data?.telefonos.length == 0
                  ? _tableRow(Container(), Container())
                  : _tableRow(
                      const Text('TELEFONO',
                          overflow: TextOverflow.ellipsis,
                          style: Constants.textStyleStandard),
                      Text('${state.data?.telefonos[0]?.telefono}',
                          style: Constants.textStyleStandard)),
              // ignore: prefer_is_empty
              state.data?.direcciones.length == 0
                  ? _tableRow(Container(), Container())
                  : _tableRow(
                      const Text('DIRECCIÓN',
                          overflow: TextOverflow.ellipsis,
                          style: Constants.textStyleStandard),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                              '${state.data?.direcciones[0]?.calle} ${state.data?.direcciones[0]?.numExterior} ${state.data?.direcciones[0]?.numInterior} ${state.data?.direcciones[0]?.colonia} ${state.data?.direcciones[0]?.codigoPostal} ${state.data?.direcciones[0]?.municipio} ${state.data?.direcciones[0]?.estado} ',
                              style: Constants.textStyleStandard,
                              textAlign: TextAlign.end))),
              _tableRow(
                  const Text('CATEGORIA',
                      overflow: TextOverflow.ellipsis,
                      style: Constants.textStyleStandard),
                  Text('${state.data?.infoSistema?.categoriaDesc}',
                      style: Constants.textStyleStandard)),
              _tableRow(
                  const Text('COORDINADOR',
                      overflow: TextOverflow.ellipsis,
                      style: Constants.textStyleStandard),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text('${state.data?.coordinador?.coordinadorDesc}',
                          style: Constants.textStyleStandard,
                          textAlign: TextAlign.end))),
              _tableRow(
                  const Text('SUCURSAL',
                      overflow: TextOverflow.ellipsis,
                      style: Constants.textStyleStandard),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text('${state.data?.sucursal?.sucursalDesc}',
                          style: Constants.textStyleStandard,
                          textAlign: TextAlign.end))),
            ]),
          ),
        )
      ],
    );
  }

  TableRow _tableRow(Widget _left, Widget _right) {
    return TableRow(children: [
      Container(
        child: _left,
        padding: const EdgeInsets.all(5.0),
      ),
      Container(
        child: Align(
          child: _right,
          alignment: Alignment.centerRight,
        ),
        padding: const EdgeInsets.all(5.0),
      ),
    ]);
  }

  Widget _button() {
    return ShakeTransition(
      child: Container(
          decoration: const BoxDecoration(
              color: Constants.colorAlternative,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              )),
          width: double.infinity,
          height: 50,
          child: ShakeTransition(
            offset: 140.0,
            duration: Duration(milliseconds: random.nextInt(3) * 1000),
            child: CustomElevatedButton(
                action: () {
                  // BlocProvider.of<UserBloc>(context, listen: false)
                  //     .add(DeleteUserEvent());
                  _showAlert();
                },
                borderColor: Constants.colorAlternative,
                primaryColor: Constants.colorAlternative,
                textColor: Colors.white,
                label:
                    'CERRAR SESIÓN' //'${!_enviando ? 'Guardar' : 'Enviando ...'}'
                ),
          )),
    );
  }
}
