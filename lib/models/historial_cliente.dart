class Historial {
  int clienteId;
  String primerNombre;
  String segundoNombre;
  String primerApellido;
  String segundoApellido;
  String fechaNacimiento;
  String curp;
  String rfc;
  int edad;
  double saldoActual;
  int estatusId;
  String estatusDesc;
  String telefono;
  String telefonoTipo;
  List<dynamic> direcciones;
  List<dynamic> creditos;
  List<dynamic> creditoPendiente;

  Historial({
    this.clienteId = 0,
    this.primerNombre = '',
    this.segundoNombre = '',
    this.primerApellido = '',
    this.segundoApellido = '',
    this.fechaNacimiento = '',
    this.curp = '',
    this.rfc = '',
    this.edad = 0,
    this.saldoActual = 0,
    this.estatusId = 0,
    this.estatusDesc = '',
    this.telefono = '',
    this.telefonoTipo = '',
    this.direcciones = const [],
    this.creditos = const [],
    this.creditoPendiente = const [],
  });

  Historial fromJson(Map<String, dynamic> json) {
    final data = Historial();
    data.clienteId = json['clienteId'];
    data.primerNombre = json['primerNombre'];
    data.segundoNombre = json['segundoNombre'];
    data.primerApellido = json['primerApellido'];
    data.segundoApellido = json['segundoApellido'];
    data.fechaNacimiento = json['fechaNacimiento'];
    data.curp = json['curp'];
    data.rfc = json['rfc'];
    data.edad = json['edad'];
    data.saldoActual = json['saldoActual'] / 1;
    data.estatusId = json['estatusId'];
    data.estatusDesc = json['estatusDesc'];
    data.telefono = json['telefono'];
    data.telefonoTipo = json['telefonoTipo'];
    data.direcciones =
        json['direcciones'].map((e) => Direccion.fromJson(e)).toList();
    data.creditos = json['creditos'].map((e) => Credito.fromJson(e)).toList();
    data.creditoPendiente =
        json['creditoPendiente'].map((e) => Credito.fromJson(e)).toList();
    return data;
  }
}

class Direccion {
  String? calle;
  String? numExterior;
  String? numInterior;
  String? colonia;
  int? codigoPostal;
  String? municipio;
  String? ciudad;
  String? estado;

  Direccion({
    this.calle = '',
    this.numExterior = '',
    this.numInterior = '',
    this.colonia = '',
    this.codigoPostal = 0,
    this.municipio = '',
    this.ciudad = '',
    this.estado = '',
  });

  Direccion.fromJson(Map<String, dynamic> json) {
    calle = json['calle'];
    numExterior = json['numExterior'];
    numInterior = json['numInterior'];
    colonia = json['colonia'];
    codigoPostal = json['codigoPostal'];
    municipio = json['municipio'];
    ciudad = json['ciudad'];
    estado = json['estado'];
  }
}

class Credito {
  int? creditoId;
  double? importe;
  int? numVale;
  double? saldoPendiente;
  String? fInicio;
  String? fFinal;
  int? plazos;
  int? plazoFaltantes;

  Credito({
    this.creditoId = 0,
    this.importe = 0,
    this.numVale = 0,
    this.saldoPendiente = 0,
    this.fInicio = '',
    this.fFinal = '',
    this.plazos = 0,
    this.plazoFaltantes = 0,
  });

  Credito.fromJson(Map<String, dynamic> json) {
    creditoId = json['creditoId'];
    importe = json['importe'] / 1;
    numVale = json['numVale'];
    saldoPendiente = json['saldoPendiente'] / 1;
    fInicio = json['fInicio'];
    fFinal = json['fFinal'];
    plazos = json['plazos'];
    plazoFaltantes = json['plazoFaltantes'];
  }
}
