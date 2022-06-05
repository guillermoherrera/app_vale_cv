class ValeDetalle {
  int plazos;
  int plazoActual;
  int folio;
  double saldoPagado;
  double saldoActual;
  double montoPago;
  String telefono;
  List<dynamic> detalleVenta;
  int noCredito;
  int noCliente;
  String nombreCliente;
  String fechaCredito;
  String status;
  double monto;

  ValeDetalle({
    this.plazos = 0,
    this.plazoActual = 0,
    this.folio = 0,
    this.saldoPagado = 0,
    this.saldoActual = 0,
    this.montoPago = 0,
    this.telefono = '',
    this.detalleVenta = const [],
    this.noCredito = 0,
    this.noCliente = 0,
    this.nombreCliente = '',
    this.fechaCredito = '',
    this.status = '',
    this.monto = 0,
  });

  ValeDetalle fromJson(Map<String, dynamic> json) {
    final data = ValeDetalle();
    data.plazos = json['plazos'];
    data.plazoActual = json['plazoActual'];
    data.folio = json['folio'];
    data.saldoPagado = json['saldoPagado'] / 1;
    data.saldoActual = json['saldoActual'] / 1;
    data.montoPago = json['montoPago'] / 1;
    data.telefono = json['telefono'];
    data.detalleVenta = json['detalleVenta'];
    data.noCredito = json['noCredito'];
    data.noCliente = json['noCliente'];
    data.nombreCliente = json['nombreCliente'];
    data.fechaCredito = json['fechaCredito'];
    data.status = json['status'];
    data.monto = json['monto'] / 1;
    return data;
  }
}
