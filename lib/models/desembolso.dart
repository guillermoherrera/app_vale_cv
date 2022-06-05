class Desembolsos {
  List<dynamic> desembolsos;

  Desembolsos({this.desembolsos = const []});

  Desembolsos fromJson(List<dynamic> json) {
    final data = Desembolsos(
        desembolsos: json.map((e) => Desembolso.fromJson(e)).toList());
    return data;
  }
}

class Desembolso {
  int? desembolsoTipoId;
  String? desembolsoTipoDesc;
  String? iconoDesembolsoTipo;
  bool? requiereDatosBancarios;
  String? nombreBanco;
  String? numeroTarjeta;

  Desembolso({
    this.desembolsoTipoId = 0,
    this.desembolsoTipoDesc = '',
    this.iconoDesembolsoTipo = '',
    this.requiereDatosBancarios = false,
    this.nombreBanco = '',
    this.numeroTarjeta = '',
  });

  Desembolso.fromJson(Map<String, dynamic> json) {
    desembolsoTipoId = json['desembolsoTipoId'];
    desembolsoTipoDesc = json['desembolsoTipoDesc'];
    iconoDesembolsoTipo = json['iconoDesembolsoTipo'];
    requiereDatosBancarios = json['requiereDatosBancarios'];
    nombreBanco = json['nombrebanco'];
    numeroTarjeta = json['numeroTarjeta'];
  }
}
