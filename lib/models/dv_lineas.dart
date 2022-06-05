class DvLineas {
  double disponibleTotal;
  double limiteTotal;
  double saldoActualTotal;
  bool atraso;
  bool relacionDisponible;
  bool accesoConfiaShop;
  String mensaje;
  double versionAndroid;
  double versionIOS;
  // ignore: non_constant_identifier_names
  String TipoPago;
  List<dynamic> detalle;

  DvLineas({
    this.disponibleTotal = 0.0,
    this.limiteTotal = 0.0,
    this.saldoActualTotal = 0.0,
    this.atraso = true,
    this.relacionDisponible = false,
    this.accesoConfiaShop = false,
    this.mensaje = '',
    this.versionAndroid = 0.0,
    this.versionIOS = 0.0,
    // ignore: non_constant_identifier_names
    this.TipoPago = 'PA',
    this.detalle = const [],
  });

  DvLineas fromJson(Map<String, dynamic> json) {
    final data = DvLineas(
      disponibleTotal: json['disponibleTotal'] / 1,
      limiteTotal: json['limiteTotal'] / 1,
      saldoActualTotal: json['saldoActualTotal'] / 1,
      atraso: json['atraso'],
      relacionDisponible: json['relacionDisponible'],
      accesoConfiaShop: json['accesoConfiaShop'],
      mensaje: json['mensaje'],
      versionAndroid: json['versionAndroid'] / 1,
      versionIOS: json['versionIOS'] / 1,
      TipoPago: json['TipoPago'],
      detalle: json['detalle'].map((e) => DvLineasDetalle.fromJson(e)).toList(),
    );
    return data;
  }
}

class DvLineasDetalle {
  String? caption;
  double? disponible;
  double? limite;
  double? saldoActual;
  double? colocacion;

  DvLineasDetalle({
    this.caption = '',
    this.disponible = 0.0,
    this.limite = 0.0,
    this.saldoActual = 0.0,
    this.colocacion = 0.0,
  });

  DvLineasDetalle.fromJson(Map<String, dynamic> json) {
    caption = json['caption'];
    disponible = json['disponible'] / 1;
    limite = json['limite'] / 1;
    saldoActual = json['saldoActual'] / 1;
    colocacion = json['colocacion'] / 1;
  }
}
