class SolicitudCredito {
  int clienteID;
  String clienteNombre;
  String clienteTelefono;
  String clienteEstatusDesc;
  int desembolsoID;
  double importe;
  int plazo;
  String tipoPlazo;
  // ignore: non_constant_identifier_names
  int CanjeAppId;
  int creditoID;

  SolicitudCredito({
    this.clienteID = 0,
    this.desembolsoID = 0,
    this.clienteNombre = '',
    this.clienteTelefono = '',
    this.clienteEstatusDesc = '',
    this.importe = 0.0,
    this.plazo = 0,
    this.tipoPlazo = '',
    // ignore: non_constant_identifier_names
    this.CanjeAppId = 0,
    this.creditoID = 0,
  });

  SolicitudCredito copyWith({
    int? clienteID,
    int? desembolsoID,
    String? clienteNombre,
    String? clienteTelefono,
    String? clienteEstatusDesc,
    double? importe,
    int? plazo,
    String? tipoPlazo,
    // ignore: non_constant_identifier_names
    int? CanjeAppId,
    int? creditoID,
  }) =>
      SolicitudCredito(
        clienteID: clienteID ?? this.clienteID,
        desembolsoID: desembolsoID ?? this.desembolsoID,
        clienteNombre: clienteNombre ?? this.clienteNombre,
        clienteTelefono: clienteTelefono ?? this.clienteTelefono,
        clienteEstatusDesc: clienteEstatusDesc ?? this.clienteEstatusDesc,
        importe: importe ?? this.importe,
        plazo: plazo ?? this.plazo,
        tipoPlazo: tipoPlazo ?? this.tipoPlazo,
        CanjeAppId: CanjeAppId ?? this.CanjeAppId,
        creditoID: creditoID ?? this.creditoID,
      );
}
