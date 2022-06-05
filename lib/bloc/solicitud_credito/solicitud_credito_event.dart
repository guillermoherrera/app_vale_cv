part of 'solicitud_credito_bloc.dart';

@immutable
abstract class SolicitudCreditoEvent {}

class GetSolicitudCredito extends SolicitudCreditoEvent {
  final SolicitudCredito data;
  GetSolicitudCredito(this.data);
}

class AddClienteID extends SolicitudCreditoEvent {
  final int clienteID;
  final String clienteNombre;
  final String clienteTelefono;
  final String clienteEstatusDesc;
  AddClienteID(this.clienteID, this.clienteNombre, this.clienteTelefono,
      this.clienteEstatusDesc);
}

class AddDesembolsoID extends SolicitudCreditoEvent {
  final int desembolsoID;
  AddDesembolsoID(this.desembolsoID);
}

class AddPlazoImporte extends SolicitudCreditoEvent {
  final double? importe;
  final int plazo;
  final String tipoPlazo;

  AddPlazoImporte(this.importe, this.plazo, this.tipoPlazo);
}

class AddCanjeAppID extends SolicitudCreditoEvent {
  // ignore: non_constant_identifier_names
  final int CanjeAppID;
  AddCanjeAppID(this.CanjeAppID);
}

class AddTelefono extends SolicitudCreditoEvent {
  final String telefono;
  AddTelefono(this.telefono);
}

class AddCreditoID extends SolicitudCreditoEvent {
  final int creditoID;
  AddCreditoID(this.creditoID);
}
