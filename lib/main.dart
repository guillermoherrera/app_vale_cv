import 'package:app_vale_cv/bloc/asentamientos/asentamientos_bloc.dart';
import 'package:app_vale_cv/bloc/cliente/cliente_bloc.dart';
import 'package:app_vale_cv/bloc/clientes/clientes_bloc.dart';
import 'package:app_vale_cv/bloc/desembolsos/desembolsos_bloc.dart';
import 'package:app_vale_cv/bloc/destinos/destinos_bloc.dart';
import 'package:app_vale_cv/bloc/dvInfo/dvinfo_bloc.dart';
import 'package:app_vale_cv/bloc/dv_lineas/dv_lineas_bloc.dart';
import 'package:app_vale_cv/bloc/dv_saldos/dv_saldos_bloc.dart';
import 'package:app_vale_cv/bloc/historial/historial_bloc.dart';
import 'package:app_vale_cv/bloc/plazos/plazos_bloc.dart';
import 'package:app_vale_cv/bloc/solicitud_credito/solicitud_credito_bloc.dart';
import 'package:app_vale_cv/bloc/user/user_bloc.dart';
import 'package:app_vale_cv/bloc/vale_detalle/vale_detalle_bloc.dart';
import 'package:app_vale_cv/bloc/vales/vales_bloc.dart';
import 'package:app_vale_cv/pages/clientes/cliente_page.dart';
import 'package:app_vale_cv/pages/clientes/nuevo_cliente_page.dart';
import 'package:app_vale_cv/pages/vales/clientes_vale_page.dart';
import 'package:app_vale_cv/pages/vales/codigo_page.dart';
import 'package:app_vale_cv/pages/vales/desembolso_page.dart';
import 'package:app_vale_cv/pages/vales/destino_page.dart';
import 'package:app_vale_cv/pages/vales/historial_vale_page.dart';
import 'package:app_vale_cv/pages/vales/plazos_page.dart';
import 'package:app_vale_cv/pages/vales/vale_page.dart';
import 'package:flutter/material.dart';

import 'package:app_vale_cv/Pages/root_page.dart';
import 'package:app_vale_cv/helpers/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => DvLineaBloc()),
        BlocProvider(create: (_) => DvinfoBloc()),
        BlocProvider(create: (_) => ClientesBloc()),
        BlocProvider(create: (_) => ClienteBloc()),
        BlocProvider(create: (_) => ValesBloc()),
        BlocProvider(create: (_) => ValeDetalleBloc()),
        BlocProvider(create: (_) => DvSaldoBloc()),
        BlocProvider(create: (_) => HistorialBloc()),
        BlocProvider(create: (_) => SolicitudCreditoBloc()),
        BlocProvider(create: (_) => DesembolsosBloc()),
        BlocProvider(create: (_) => PlazosBloc()),
        BlocProvider(create: (_) => DestinosBloc()),
        BlocProvider(create: (_) => AsentamientosBloc()),
      ],
      child: MaterialApp(
        title: 'App Vale CV',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Constants.colorPrimary),
        initialRoute: Constants.pageRoot,
        routes: {
          Constants.pageRoot: (BuildContext context) => const RootPage(),
          Constants.pageCliente: (BuildContext context) => const ClientePage(),
          Constants.pageVale: (BuildContext context) => const ValePage(),
          Constants.pageClientesVale: (BuildContext context) =>
              const ClientesValePage(),
          Constants.pageDesembolso: (BuildContext context) =>
              const DesembolsoPage(),
          Constants.pagePlazos: (BuildContext context) => const PlazosPage(),
          Constants.pageDestinos: (BuildContext context) => const DestinoPage(),
          Constants.pageHistorial: (BuildContext context) =>
              const HistorialPage(),
          Constants.pageCodigo: (BuildContext context) => const CodigoPage(),
          Constants.pageNuevoCliente: (BuildContext context) =>
              const NuevoClientePage(),
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('es')],
      ),
    );
  }
}
