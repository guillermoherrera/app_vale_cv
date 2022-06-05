class Vales {
  List<dynamic> vales;

  Vales({this.vales = const []});

  Vales fromJson(List<dynamic> json) {
    final data = Vales(vales: json.map((e) => Vale.fromJson(e)).toList());
    return data;
  }
}

class Vale {
  int? valeId;
  String? fhRegistro;
  bool? cancelado;
  String? fhCancelacion;
  int? valeraDetalleId;
  String? nombreCliente;
  double? importe;
  int? plazos;
  String? codigoVale;
  int? canjeId;
  String? status;
  int? creditoId;

  Vale({
    this.valeId = 0,
    this.fhRegistro = '',
    this.cancelado = false,
    this.fhCancelacion = '',
    this.valeraDetalleId = 0,
    this.nombreCliente = '',
    this.importe = 0,
    this.plazos = 0,
    this.codigoVale = '',
    this.canjeId = 0,
    this.status = '',
    this.creditoId = 0,
  });

  Vale.fromJson(Map<String, dynamic> json) {
    valeId = json['valeId'];
    fhRegistro = json['fhRegistro'];
    cancelado = json['cancelado'];
    fhCancelacion = json['fhCancelacion'];
    valeraDetalleId = json['valeraDetalleId'];
    nombreCliente = json['nombreCliente'];
    importe = json['importe'] / 1;
    plazos = json['plazos'];
    codigoVale = json['codigoVale'];
    canjeId = json['canjeId'];
    status = json['status'];
    creditoId = json['creditoId'];
  }
}
