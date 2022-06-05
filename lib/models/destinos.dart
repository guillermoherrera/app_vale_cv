class Destinos {
  List<dynamic> destinos;

  Destinos({this.destinos = const []});

  Destinos fromJson(List<dynamic> json) {
    final data =
        Destinos(destinos: json.map((e) => Destino.fromJson(e)).toList());
    return data;
  }
}

class Destino {
  int? motivoTipoId;
  String? motivoTipoDesc;
  String? iconoMotivoTipo;

  Destino({
    this.motivoTipoId = 0,
    this.motivoTipoDesc = '',
    this.iconoMotivoTipo = '',
  });

  Destino.fromJson(Map<String, dynamic> json) {
    motivoTipoId = json['motivoTipoId'];
    motivoTipoDesc = json['motivoTipoDesc'];
    iconoMotivoTipo = json['iconoMotivoTipo'];
  }
}
