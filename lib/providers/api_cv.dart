// ignore_for_file: library_prefixes

import 'package:app_vale_cv/bloc/asentamientos/asentamientos_bloc.dart';
import 'package:app_vale_cv/bloc/cliente/cliente_bloc.dart';
import 'package:app_vale_cv/bloc/desembolsos/desembolsos_bloc.dart';
import 'package:app_vale_cv/bloc/destinos/destinos_bloc.dart';
import 'package:app_vale_cv/bloc/historial/historial_bloc.dart';
import 'package:app_vale_cv/bloc/plazos/plazos_bloc.dart';
import 'package:app_vale_cv/bloc/vale_detalle/vale_detalle_bloc.dart';
import 'package:app_vale_cv/bloc/vales/vales_bloc.dart';
import 'package:app_vale_cv/models/asentamientos.dart';
import 'package:app_vale_cv/models/cliente.dart' as alta;
import 'package:app_vale_cv/models/desembolso.dart';
import 'package:app_vale_cv/models/destinos.dart';
import 'package:app_vale_cv/models/historial_cliente.dart';
import 'package:app_vale_cv/models/solicitud_credito.dart';
import 'package:app_vale_cv/models/vale.dart';
import 'package:app_vale_cv/models/vales.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_vale_cv/models/clientes.dart';
import 'package:app_vale_cv/models/dv_lineas.dart';
import 'package:app_vale_cv/models/dvinfo.dart';
import 'package:app_vale_cv/bloc/clientes/clientes_bloc.dart';
import 'package:app_vale_cv/bloc/dvInfo/dvinfo_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../bloc/dv_lineas/dv_lineas_bloc.dart';
import 'package:app_vale_cv/providers/custom_request.dart';
import 'package:app_vale_cv/helpers/constants.dart';

import '../bloc/dv_saldos/dv_saldos_bloc.dart';
import '../bloc/solicitud_credito/solicitud_credito_bloc.dart';
import '../models/canje_vale_app.dart';
import '../models/dv_saldos.dart';
import '../models/enviar_codigo.dart';
import '../models/plazos.dart';

class ApiCV {
  final secureStorage = const FlutterSecureStorage();
  final _customRequest = CustomRequest();

  Future<Dvinfo> getDvinfo(BuildContext context) async {
    final url = Uri.https(Constants.apiBase, Constants.apiDvinfo);
    String dvID = await secureStorage.read(key: 'DistribuidorID');
    Map<String, int> params = {"DistribuidorID": int.parse(dvID)};
    final body = jsonEncode(params);
    Dvinfo model = Dvinfo();
    Dvinfo res = await _customRequest.request(url, body, model, context);
    final classBloc = BlocProvider.of<DvinfoBloc>(context, listen: false);
    classBloc.add(GetDvInfo(res));
    return res;
  }

  Future<DvLineas> getDvLineas(BuildContext context) async {
    final url = Uri.https(Constants.apiBase, Constants.apiDvLineas);
    String dvID = await secureStorage.read(key: 'DistribuidorID');
    Map<String, int> params = {"DistribuidorID": int.parse(dvID)};
    final body = jsonEncode(params);
    DvLineas model = DvLineas();
    DvLineas res = await _customRequest.request(url, body, model, context);
    final classBloc = BlocProvider.of<DvLineaBloc>(context, listen: false);
    classBloc.add(GetLineas(res));
    return res;
  }

  Future<Clientes> getClientes(BuildContext context) async {
    final url = Uri.https(Constants.apiBase, Constants.apiClientes);
    String dvID = await secureStorage.read(key: 'DistribuidorID');
    Map<String, int> params = {"DistribuidorID": int.parse(dvID)};
    final body = jsonEncode(params);
    Clientes model = Clientes();
    Clientes res = await _customRequest.request(url, body, model, context);
    final classBloc = BlocProvider.of<ClientesBloc>(context, listen: false);
    classBloc.add(GetClientes(res));
    return res;
  }

  Future<Vales> getVales(BuildContext context) async {
    final url = Uri.https(Constants.apiBase, Constants.apiVales);
    String dvID = await secureStorage.read(key: 'DistribuidorID');
    Map<String, int> params = {
      "DistribuidorID": int.parse(dvID),
      "ProductoID": 1
    };
    final body = jsonEncode(params);
    Vales model = Vales();
    Vales res = await _customRequest.request(url, body, model, context);
    final classBloc = BlocProvider.of<ValesBloc>(context, listen: false);
    classBloc.add(GetVales(res));
    return res;
  }

  Future<ValeDetalle> getValeDetalle(BuildContext context) async {
    final url = Uri.https(Constants.apiBase, Constants.apiValesDetalle);
    SolicitudCreditoState solicitudCredito =
        context.read<SolicitudCreditoBloc>().state;
    String dvID = await secureStorage.read(key: 'DistribuidorID');
    Map<String, int> params = {
      "DistribuidorID": int.parse(dvID),
      "CreditoID": solicitudCredito.data!.creditoID
    };
    final body = jsonEncode(params);
    ValeDetalle model = ValeDetalle();
    ValeDetalle res = await _customRequest.request(url, body, model, context);
    final classBloc = BlocProvider.of<ValeDetalleBloc>(context, listen: false);
    classBloc.add(GetValeDetalle(res));
    return res;
  }

  Future<DvSaldos> getDvSaldos(BuildContext context) async {
    final url = Uri.https(Constants.apiBase, Constants.apiDvSaldos);
    String dvID = await secureStorage.read(key: 'DistribuidorID');
    Map<String, int> params = {"DistribuidorID": int.parse(dvID)};
    final body = jsonEncode(params);
    DvSaldos model = DvSaldos();
    DvSaldos res = await _customRequest.request(url, body, model, context);
    final classBloc = BlocProvider.of<DvSaldoBloc>(context, listen: false);
    classBloc.add(GetSld(res));
    return res;
  }

  Future<Historial> getHistorialCliente(BuildContext context) async {
    final url = Uri.https(Constants.apiBase, Constants.apiHistorialCliente);
    SolicitudCreditoState solicitudCredito =
        context.read<SolicitudCreditoBloc>().state;
    String dvID = await secureStorage.read(key: 'DistribuidorID');
    Map<String, int> params = {
      "DistribuidorID": int.parse(dvID),
      "ClienteID": solicitudCredito.data!.clienteID
    };
    final body = jsonEncode(params);
    Historial model = Historial();
    Historial res = await _customRequest.request(url, body, model, context);
    final classBloc = BlocProvider.of<HistorialBloc>(context, listen: false);
    classBloc.add(GetHistorial(res));
    return res;
  }

  Future<Desembolsos> getDesembolsosTipos(BuildContext context) async {
    final url = Uri.https(Constants.apiBase, Constants.apiDesembolsos);
    SolicitudCreditoState solicitudCredito =
        context.read<SolicitudCreditoBloc>().state;
    String dvID = await secureStorage.read(key: 'DistribuidorID');
    Map<String, int> params = {
      "DistribuidorID": int.parse(dvID),
      "ClienteID": solicitudCredito.data!.clienteID
    };
    final body = jsonEncode(params);
    Desembolsos model = Desembolsos();
    Desembolsos res = await _customRequest.request(url, body, model, context);
    final classBloc = BlocProvider.of<DesembolsosBloc>(context, listen: false);
    classBloc.add(GetDesembolsos(res));
    return res;
  }

  Future<Plazos> getPlazosImporte(BuildContext context) async {
    final url = Uri.https(Constants.apiBase, Constants.apiPlazosImporte);
    SolicitudCreditoState solicitudCredito =
        context.read<SolicitudCreditoBloc>().state;
    DvinfoState dvInfo = context.read<DvinfoBloc>().state;
    String dvID = await secureStorage.read(key: 'DistribuidorID');
    Map<String, int> params = {
      "DistribuidorID": int.parse(dvID),
      "ClienteID": solicitudCredito.data!.clienteID,
      "SucursalID": dvInfo.data!.sucursal?.sucursalId ?? 0
    };
    final body = jsonEncode(params);
    Plazos model = Plazos();
    Plazos res = await _customRequest.request(url, body, model, context);
    final classBloc = BlocProvider.of<PlazosBloc>(context, listen: false);
    classBloc.add(GetPlazos(res));
    return res;
  }

  Future<Destinos> getDestinos(BuildContext context) async {
    final url = Uri.https(Constants.apiBase, Constants.apiDestinos);
    String dvID = await secureStorage.read(key: 'DistribuidorID');
    Map<String, int> params = {"DistribuidorID": int.parse(dvID)};
    final body = jsonEncode(params);
    Destinos model = Destinos();
    Destinos res = await _customRequest.request(url, body, model, context);
    final classBloc = BlocProvider.of<DestinosBloc>(context, listen: false);
    classBloc.add(GetDestinos(res));
    return res;
  }

  Future<bool> solicitarCredito(BuildContext context) async {
    final url = Uri.https(Constants.apiBase, Constants.apiSolicitar);
    String dvID = await secureStorage.read(key: 'DistribuidorID');
    SolicitudCreditoState solicitudCredito =
        context.read<SolicitudCreditoBloc>().state;
    DvinfoState dvInfo = context.read<DvinfoBloc>().state;
    Map<String, dynamic> params = {
      "ProductoID": 1, //<<--YA SE MANDA EN EL HEADER
      "DistribuidorID": int.parse(dvID),
      "ClienteID": solicitudCredito.data!.clienteID,
      "SucursalID": dvInfo.data!.sucursal?.sucursalId ?? 0,
      "SerieId": 8, //<<--¿?
      "Capital": solicitudCredito.data!.importe.toInt(),
      "Plazos": solicitudCredito.data!.plazo,
      "UsuarioID": 28, // SE PUEDE TOMAR DEL DVID Y EL PRODUCTOUID?
      "PersonaID": 7756, // ES EL DVID?
      "personasDatosBancariosID": 0, //AGREGAR
      "TipoDesembolsoID": solicitudCredito.data!.desembolsoID
    };
    final body = jsonEncode(params);
    CanjeValeApp model = CanjeValeApp();
    CanjeValeApp res =
        await _customRequest.requestBORRAR(url, body, model, context);
    if (res.CanjeAppId > 0) {
      final solicitudBloc =
          BlocProvider.of<SolicitudCreditoBloc>(context, listen: false);
      solicitudBloc.add(AddCanjeAppID(res.CanjeAppId));
      return true;
    }
    return false;
  }

  Future<bool> enviarSMSCredito(BuildContext context) async {
    final url = Uri.https(Constants.apiBase, Constants.apiEnviarSms);
    String empresaId = await secureStorage.read(key: 'empresaId');
    SolicitudCreditoState solicitudCredito =
        context.read<SolicitudCreditoBloc>().state;
    Map<String, dynamic> params = {
      "CanjeAppId": solicitudCredito.data!.CanjeAppId,
      "PersonaID": solicitudCredito.data!.clienteID,
      "Telefono": solicitudCredito.data!.clienteTelefono,
      "src": "Empresa $empresaId"
    };
    final body = jsonEncode(params);
    EnviarCodigo model = EnviarCodigo();
    EnviarCodigo res = await _customRequest.request(url, body, model, context);
    if (res.Id > 0) {
      return true;
    }
    return false;
  }

  Future<bool> confirmarCodigo(BuildContext context, String codigo) async {
    final url = Uri.https(Constants.apiBase, Constants.apiconfirmarCodigo);
    SolicitudCreditoState solicitudCredito =
        context.read<SolicitudCreditoBloc>().state;
    Map<String, dynamic> params = {
      "CanjeAppId": solicitudCredito.data!.CanjeAppId,
      "Codigo": codigo
    };
    final body = jsonEncode(params);
    EnviarCodigo model = EnviarCodigo();
    EnviarCodigo res = await _customRequest.request(url, body, model, context);
    if (res.Confirmado) {
      return true;
    }
    return false;
  }

  Future<bool> consultaCurp(BuildContext context, String curp) async {
    final url = Uri.https(Constants.apiBase, Constants.apiClienteXCurp);
    Map<String, dynamic> params = {"CURP": curp};
    final body = jsonEncode(params);
    alta.Cliente model = alta.Cliente();
    alta.Cliente res = await _customRequest.request(url, body, model, context);
    final classBloc = BlocProvider.of<ClienteBloc>(context, listen: false);
    classBloc.add(GetCliente(res));
    if (res.persona != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<Asentamientos> getAsentamientos(BuildContext context, int cp) async {
    final url = Uri.https(Constants.apiBase, Constants.apiAsentamientos);
    Map<String, int> params = {"CodigoPostal": cp};
    final body = jsonEncode(params);
    Asentamientos model = Asentamientos();
    Asentamientos res = await _customRequest.request(url, body, model, context);
    final classBloc =
        BlocProvider.of<AsentamientosBloc>(context, listen: false);
    classBloc.add(GetAsentamientos(res));
    return res;
  }
}
