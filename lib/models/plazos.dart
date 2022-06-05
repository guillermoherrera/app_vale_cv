class Plazos {
  List<dynamic> plazos;

  Plazos({this.plazos = const []});

  Plazos fromJson(List<dynamic> json) {
    final data = Plazos(plazos: json.map((e) => Plazo.fromJson(e)).toList());
    return data;
  }
}

class Plazo {
  int? plazo;
  List<dynamic>? tipoPlazos;
  Plazo({
    this.plazo = 0,
    this.tipoPlazos = const [],
  });

  Plazo.fromJson(Map<String, dynamic> json) {
    plazo = json['plazo'];
    tipoPlazos = json['tipoPlazos'];
  }
}

class TipoPlazo {
  int? tipoPlazoId;
  List<dynamic>? importes;
  TipoPlazo({
    this.tipoPlazoId = 0,
    this.importes = const [],
  });

  TipoPlazo.fromJson(Map<String, dynamic> json) {
    tipoPlazoId = json['plazo'];
    importes = json['importes'];
  }
}

class Importe {
  double? importe;
  double? importePagoPlazo;
  Importe({
    this.importe = 0,
    this.importePagoPlazo = 0,
  });

  Importe.fromJson(Map<String, dynamic> json) {
    importe = json['importe'];
    importePagoPlazo = json['importePagoPlazo'];
  }
}
