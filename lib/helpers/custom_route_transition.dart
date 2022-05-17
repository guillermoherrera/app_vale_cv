import 'package:app_vale_cv/pages/vales/clientes_vale_page.dart';
import 'package:app_vale_cv/pages/vales/desembolso_page.dart';
import 'package:app_vale_cv/pages/vales/destino_page.dart';
import 'package:app_vale_cv/pages/vales/plazos_page.dart';
import 'package:app_vale_cv/pages/vales/vale_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_vale_cv/helpers/constants.dart';
import 'package:app_vale_cv/pages/clientes/cliente_page.dart';
import 'package:app_vale_cv/pages/root_page.dart';

class CustomRouteTransition {
  Route createRutaSlide(String route) {
    Widget ruta = _getPage(route);

    return PageRouteBuilder(
        pageBuilder: ((context, animation, secondaryAnimation) => ruta),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation =
              CurvedAnimation(parent: animation, curve: Curves.ease);
          return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                      .animate(curvedAnimation),
              child: child);
        });
  }

  Widget _getPage(String ruta) {
    switch (ruta) {
      case Constants.pageCliente:
        return const ClientePage();
      case Constants.pageVale:
        return const ValePage();
      case Constants.pageClientesVale:
        return const ClientesValePage();
      case Constants.pageDesembolso:
        return const DesembolsoPage();
      case Constants.pagePlazos:
        return const PlazosPage();
      case Constants.pageDestinos:
        return const DestinoPage();
      default:
        return const RootPage();
    }
  }
}
