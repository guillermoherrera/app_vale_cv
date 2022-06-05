part of 'solicitud_credito_bloc.dart';

@immutable
abstract class SolicitudCreditoState {
  final SolicitudCredito? data;

  const SolicitudCreditoState({this.data});
}

class SolicitudCreditoIntialState extends SolicitudCreditoState {
  SolicitudCreditoIntialState() : super(data: SolicitudCredito());
}

class SolicitudCreditoSetState extends SolicitudCreditoState {
  final SolicitudCredito newSolicitud;
  const SolicitudCreditoSetState(this.newSolicitud) : super(data: newSolicitud);
}
