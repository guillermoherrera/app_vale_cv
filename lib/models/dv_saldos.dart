class DvSaldos {
  List<dynamic>? bonificaciones;
  List<dynamic>? relaciones;
  DvDetalleLineaCredito? detalleLineaCredito;
  DvDetallePrestamoPersonal? detallePrestamoPersonal;

  DvSaldos(
      {this.bonificaciones = const [],
      this.relaciones = const [],
      this.detalleLineaCredito,
      this.detallePrestamoPersonal});

  DvSaldos fromJson(Map<String, dynamic> json) {
    final data = DvSaldos(
      bonificaciones: json['bonificaciones']
          .map((e) => DvBonificaciones.fromJson(e))
          .toList(),
      relaciones:
          json['relaciones'].map((e) => DvRelaciones.fromJson(e)).toList(),
      detalleLineaCredito:
          DvDetalleLineaCredito.fromJson(json['detalleLineaCredito']),
      detallePrestamoPersonal:
          DvDetallePrestamoPersonal.fromJson(json['detallePrestamoPersonal']),
    );
    return data;
  }
}

class DvBonificaciones {
  String? fechaPago;
  double? porcentaje;
  double? bonificacion;
  double? pago;

  DvBonificaciones(
      {this.fechaPago, this.porcentaje, this.bonificacion, this.pago});

  DvBonificaciones.fromJson(Map<String, dynamic> json) {
    fechaPago = json['FechaPago'];
    porcentaje = json['Porcentaje'] / 1;
    bonificacion = json['Bonificacion'] / 1;
    pago = json['Pago'] / 1;
  }
}

class DvRelaciones {
  String? fechaCorte;
  String? fechaRelacion;
  double? limiteCredito;
  double? saldoColocado;
  double? saldoDisponible;
  double? importeTotal;
  double? capital;
  double? interes;
  double? seguro;
  double? saldoActual;
  double? importePago;
  double? saldoAbonado;
  double? saldoAtrasado;
  int? diasAtraso;

  DvRelaciones(
      {this.fechaCorte = '',
      this.fechaRelacion = '',
      this.limiteCredito = 0.0,
      this.saldoColocado = 0.0,
      this.saldoDisponible = 0.0,
      this.importeTotal = 0.0,
      this.capital = 0.0,
      this.interes = 0.0,
      this.seguro = 0.0,
      this.saldoActual = 0.0,
      this.importePago = 0.0,
      this.saldoAbonado = 0.0,
      this.saldoAtrasado = 0.0,
      this.diasAtraso = 0});

  DvRelaciones.fromJson(Map<String, dynamic> json) {
    fechaCorte = json['fechaCorte'];
    fechaRelacion = json['fechaRelacion'];
    limiteCredito = json['limiteCredito'] / 1;
    saldoColocado = json['saldoColocado'] / 1;
    saldoDisponible = json['saldoDisponible'] / 1;
    importeTotal = json['importeTotal'] / 1;
    capital = json['capital'] / 1;
    interes = json['interes'] / 1;
    seguro = json['seguro'] / 1;
    saldoActual = json['SaldoActual'] / 1;
    importePago = json['importePago'] / 1;
    saldoAbonado = json['saldoAbonado'] / 1;
    saldoAtrasado = json['saldoAtrasado'] / 1;
    diasAtraso = json['diasAtraso'];
  }
}

class DvDetalleLineaCredito {
  int? valesColocados;
  double? importeLineaCredito;
  double? capitalLineaCredito;
  double? interesLineaCredito;
  double? seguroLineaCredito;
  double? saldoActualLineaCredito;
  double? importePagoLineaCredito;
  double? saldoAbonadoLineaCredito;
  double? saldoAtrasadoLineaCredito;
  int? diasAtrasoLineaCredito;

  DvDetalleLineaCredito(
      {this.valesColocados = 0,
      this.importeLineaCredito = 0.0,
      this.capitalLineaCredito = 0.0,
      this.interesLineaCredito = 0.0,
      this.seguroLineaCredito = 0.0,
      this.saldoActualLineaCredito = 0.0,
      this.importePagoLineaCredito = 0.0,
      this.saldoAbonadoLineaCredito = 0.0,
      this.saldoAtrasadoLineaCredito = 0.0,
      this.diasAtrasoLineaCredito = 0});

  DvDetalleLineaCredito.fromJson(Map<String, dynamic> json) {
    valesColocados = json['valesColocados'];
    importeLineaCredito = json['importeLineaCredito'] / 1;
    capitalLineaCredito = json['capitalLineaCredito'] / 1;
    interesLineaCredito = json['interesLineaCredito'] / 1;
    seguroLineaCredito = json['seguroLineaCredito'] / 1;
    saldoActualLineaCredito = json['saldoActualLineaCredito'] / 1;
    importePagoLineaCredito = json['importePagoLineaCredito'] / 1;
    saldoAbonadoLineaCredito = json['saldoAbonadoLineaCredito'] / 1;
    saldoAtrasadoLineaCredito = json['saldoAtrasadoLineaCredito'] / 1;
    diasAtrasoLineaCredito = json['diasAtrasoLineaCredito'];
  }
}

class DvDetallePrestamoPersonal {
  int? numPrestamos;
  double? importePrestamoPersonal;
  double? capitalPrestamoPersonal;
  double? interesPrestamoPersonal;
  double? seguroPrestamoPersonal;
  double? saldoActualPrestamoPersonal;
  double? importePagoPrestamoPersonal;
  double? saldoAbonadoPrestamoPersonal;
  double? saldoAtrasadoPrestamoPersonal;
  int? diasAtrasoPrestamoPersonal;

  DvDetallePrestamoPersonal(
      {this.numPrestamos = 0,
      this.importePrestamoPersonal = 0.0,
      this.capitalPrestamoPersonal = 0.0,
      this.interesPrestamoPersonal = 0.0,
      this.seguroPrestamoPersonal = 0.0,
      this.saldoActualPrestamoPersonal = 0.0,
      this.importePagoPrestamoPersonal = 0.0,
      this.saldoAbonadoPrestamoPersonal = 0.0,
      this.saldoAtrasadoPrestamoPersonal = 0.0,
      this.diasAtrasoPrestamoPersonal = 0});

  DvDetallePrestamoPersonal.fromJson(Map<String, dynamic> json) {
    numPrestamos = json['numPrestamos'];
    importePrestamoPersonal = json['importePrestamoPersonal'] / 1;
    capitalPrestamoPersonal = json['capitalPrestamoPersonal'] / 1;
    interesPrestamoPersonal = json['interesPrestamoPersonal'] / 1;
    seguroPrestamoPersonal = json['seguroPrestamoPersonal'] / 1;
    saldoActualPrestamoPersonal = json['saldoActualPrestamoPersonal'] / 1;
    importePagoPrestamoPersonal = json['importePagoPrestamoPersonal'] / 1;
    saldoAbonadoPrestamoPersonal = json['saldoAbonadoPrestamoPersonal'] / 1;
    saldoAtrasadoPrestamoPersonal = json['saldoAtrasadoPrestamoPersonal'] / 1;
    diasAtrasoPrestamoPersonal = json['diasAtrasoPrestamoPersonal'];
  }
}
