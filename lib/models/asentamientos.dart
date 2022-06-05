// ignore_for_file: non_constant_identifier_names

class Asentamientos {
  List<dynamic> asentamientos;

  Asentamientos({this.asentamientos = const []});

  Asentamientos fromJson(List<dynamic> json) {
    final data = Asentamientos(
        asentamientos: json.map((e) => AsentamientoInfo.fromJson(e)).toList());
    return data;
  }
}

class AsentamientoInfo {
  int? AsentamientoID;
  int? CodigoPostal;
  String? Asentamiento;
  String? Tipo_asenta;
  String? Municipio;
  String? Estado;
  String? Ciudad;
  String? oficina_postal;
  int? id_estado;
  String? id_oficina_postal;
  String? c_CP;
  int? id_tipo_asentamiento;
  int? id_municipio;
  int? id_asentamiento;
  String? zona;
  int? id_ciudad;

  AsentamientoInfo({
    this.AsentamientoID = 0,
    this.CodigoPostal = 0,
    this.Asentamiento = '',
    this.Tipo_asenta = '',
    this.Municipio = '',
    this.Estado = '',
    this.Ciudad = '',
    this.oficina_postal = '',
    this.id_estado = 0,
    this.id_oficina_postal = '',
    this.c_CP = '',
    this.id_tipo_asentamiento = 0,
    this.id_municipio = 0,
    this.id_asentamiento = 0,
    this.zona = '',
    this.id_ciudad = 0,
  });

  AsentamientoInfo.fromJson(Map<String, dynamic> json) {
    AsentamientoID = json['AsentamientoID'];
    CodigoPostal = json['CodigoPostal'];
    Asentamiento = json['Asentamiento'];
    Tipo_asenta = json['Tipo_asenta'];
    Municipio = json['Municipio'];
    Estado = json['Estado'];
    Ciudad = json['Ciudad'];
    oficina_postal = json['oficina_postal'];
    id_estado = json['id_estado'];
    id_oficina_postal = json['id_oficina_postal'];
    c_CP = json['c_CP'];
    id_tipo_asentamiento = json['id_tipo_asentamiento'];
    id_municipio = json['id_municipio'];
    id_asentamiento = json['id_asentamiento'];
    zona = json['zona'];
    id_ciudad = json['id_ciudad'];
  }
}
