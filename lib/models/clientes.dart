class Clientes {
  List<dynamic> clientes;

  Clientes({this.clientes = const []});

  Clientes fromJson(List<dynamic> json) {
    final data =
        Clientes(clientes: json.map((e) => Cliente.fromJson(e)).toList());
    return data;
  }
}

class Cliente {
  int? clienteId;
  String? primerNombre;
  String? segundoNombre;
  String? primerApellido;
  String? segundoApellido;
  String? fechaNacimiento;
  int? estatusId;
  String? estatusDesc;
  String? telefono;

  Cliente({
    this.clienteId = 0,
    this.primerNombre = '',
    this.segundoNombre = '',
    this.primerApellido = '',
    this.segundoApellido = '',
    this.fechaNacimiento = '',
    this.estatusId = 0,
    this.estatusDesc = '',
    this.telefono = '',
  });

  Cliente.fromJson(Map<String, dynamic> json) {
    clienteId = json['clienteId'];
    primerNombre = json['primerNombre'];
    segundoNombre = json['segundoNombre'];
    primerApellido = json['primerApellido'];
    segundoApellido = json['segundoApellido'];
    fechaNacimiento = json['fechaNacimiento'];
    estatusId = json['estatusId'];
    estatusDesc = json['estatusDesc'];
    telefono = json['telefono'];
  }
}
