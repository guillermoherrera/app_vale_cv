import 'package:app_vale_cv/bloc/user/user_bloc.dart';
import 'package:app_vale_cv/pages/clientes/cliente_page.dart';
import 'package:app_vale_cv/pages/vales/desembolso.dart';
import 'package:app_vale_cv/pages/vales/destino.dart';
import 'package:app_vale_cv/pages/vales/plazos_page.dart';
import 'package:app_vale_cv/pages/vales/vale_page.dart';
import 'package:flutter/material.dart';

import 'package:app_vale_cv/Pages/root_page.dart';
import 'package:app_vale_cv/helpers/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => UserBloc())],
      child: MaterialApp(
        title: 'App Vale CV',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Constants.colorPrimary),
        initialRoute: Constants.pageRoot,
        routes: {
          Constants.pageRoot: (BuildContext context) => const RootPage(),
          Constants.pageCliente: (BuildContext context) => const ClientePage(),
          Constants.pageVale: (BuildContext context) => const ValePage(),
          Constants.pageDesembolso: (BuildContext context) =>
              const DesembolsoPage(),
          Constants.pagePlazos: (BuildContext context) => const PlazosPage(),
          Constants.pageDestinos: (BuildContext context) => const DestinoPage(),
        },
      ),
    );
  }
}
