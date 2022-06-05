class Dvinfo {
  int distribuidorId;
  String primerNombre;
  String segundoNombre;
  String primerApellido;
  String segundoApellido;
  String fechaNacimiento;
  String curp;
  String rfc;
  int edad;
  int categoriaId;
  InfoSistema? infoSistema;
  List<dynamic> telefonos;
  List<dynamic> direcciones;
  Credito? credito;
  Categoria? categoria;
  Coordinador? coordinador;
  Sucursal? sucursal;

  Dvinfo(
      {this.distribuidorId = 0,
      this.primerNombre = '',
      this.segundoNombre = '',
      this.primerApellido = '',
      this.segundoApellido = '',
      this.fechaNacimiento = '',
      this.curp = '',
      this.rfc = '',
      this.edad = 0,
      this.categoriaId = 0,
      this.infoSistema,
      this.telefonos = const [],
      this.direcciones = const [],
      this.credito,
      this.categoria,
      this.coordinador,
      this.sucursal});

  Dvinfo fromJson(Map<String, dynamic> json) {
    final data = Dvinfo();
    data.distribuidorId = json['distribuidorId'];
    data.distribuidorId = json['distribuidorId'];
    data.primerNombre = json['primerNombre'];
    data.segundoNombre = json['segundoNombre'];
    data.primerApellido = json['primerApellido'];
    data.segundoApellido = json['segundoApellido'];
    data.fechaNacimiento = json['fechaNacimiento'];
    data.curp = json['curp'];
    data.rfc = json['rfc'];
    data.edad = json['edad'];
    data.categoriaId = json['categoriaId'];
    data.infoSistema = InfoSistema.fromJson(json['infoSistema']);
    data.telefonos =
        json['telefonos'].map((e) => Telefono.fromJson(e)).toList();
    data.direcciones =
        json['direcciones'].map((e) => Direccion.fromJson(e)).toList();
    data.credito = Credito.fromJson(json['credito']);
    data.categoria = Categoria.fromJson(json['categoria']);
    data.coordinador = Coordinador.fromJson(json['coordinador']);
    data.sucursal = Sucursal.fromJson(json['sucursal']);
    return data;
  }
}

class InfoSistema {
  String? categoriaDesc;
  String? sistemaId;
  String? sistemaDesc;
  bool? direccionActualizada;
  double? versionAndroid;
  double? versionIOS;

  InfoSistema({
    this.categoriaDesc = '',
    this.sistemaId = '',
    this.sistemaDesc = '',
    this.direccionActualizada = false,
    this.versionAndroid = 1.0,
    this.versionIOS = 1.0,
  });

  InfoSistema.fromJson(Map<String, dynamic> json) {
    categoriaDesc = json['categoriaDesc'];
    sistemaId = json['sistemaId'];
    sistemaDesc = json['sistemaDesc'];
    direccionActualizada = json['direccionActualizada'];
    versionAndroid = json['versionAndroid'] / 1;
    versionIOS = json['versionIOS'] / 1;
  }
}

class Telefono {
  int? id;
  String? telefonoTipo;
  String? telefono;

  Telefono({this.id = 0, this.telefonoTipo = '', this.telefono = ''});

  Telefono.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    telefonoTipo = json['telefonoTipo'];
    telefono = json['telefono'];
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
  String? estadoId;
  String? estadoString;
  String? fechaAutorizado;

  Credito(
      {this.estadoId = '', this.estadoString = '', this.fechaAutorizado = ''});

  Credito.fromJson(Map<String, dynamic> json) {
    estadoId = json['estadoId'];
    estadoString = json['estadoString'];
    fechaAutorizado = json['fechaAutorizado'];
  }
}

class Categoria {
  int? categoriaId;
  String? categoriaDesc;

  Categoria({this.categoriaId = 0, this.categoriaDesc = ''});

  Categoria.fromJson(Map<String, dynamic> json) {
    categoriaId = json['categoriaId'];
    categoriaDesc = json['categoriaDesc'];
  }
}

class Coordinador {
  int? coordinadorId;
  String? coordinadorDesc;

  Coordinador({this.coordinadorId = 0, this.coordinadorDesc = ''});

  Coordinador.fromJson(Map<String, dynamic> json) {
    coordinadorId = json['coordinadorId'];
    coordinadorDesc = json['coordinadorDesc'];
  }
}

class Sucursal {
  int? sucursalId;
  String? sucursalDesc;

  Sucursal({this.sucursalId = 0, this.sucursalDesc = ''});

  Sucursal.fromJson(Map<String, dynamic> json) {
    sucursalId = json['sucursalId'];
    sucursalDesc = json['sucursalDesc'];
  }
}
