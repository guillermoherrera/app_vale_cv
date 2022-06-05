// ignore_for_file: non_constant_identifier_names

class Cliente {
  Persona? persona;
  List<dynamic>? direcciones;
  Cliente({
    this.persona,
    this.direcciones = const [],
  });

  Cliente fromJson(Map<String, dynamic> json) {
    final data = Cliente();
    // ignore: unnecessary_null_comparison
    if (json == null) return data;
    data.persona = Persona.fromJson(json['persona']);
    data.direcciones =
        json['direcciones'].map((e) => Direccion.fromJson(e)).toList();
    return data;
  }
}

class Persona {
  int? PersonaID;
  int? ClienteID;
  int? DistribuidorID;
  String? CURP;
  String? RFC;
  String? Nombre;
  String? primerNombre;
  String? segundoNombre;
  String? primerApellido;
  String? segundoApellido;
  String? FechaNacimiento;
  String? EstadoCivilID;
  String? EstadoCivil;
  double? IngresosMensuales;
  String? TelefonoMovil;
  int? EscolaridadID;
  String? Escolaridad;
  String? NombreConyuge;
  int? identificacionTipoId;
  String? identificacionNumero;
  String? TelefonoDomicilio;
  String? CorreoElectronico;
  int? DependientesEconomicos;
  String? Observaciones;
  int? edad;
  String? SexoID;
  String? NombreCompleto;
  int? PagareEstatusId;
  int? ProductoID;

  Persona({
    this.PersonaID = 0,
    this.ClienteID = 0,
    this.DistribuidorID = 0,
    this.CURP = '',
    this.RFC = '',
    this.Nombre = '',
    this.primerNombre = '',
    this.segundoNombre = '',
    this.primerApellido = '',
    this.segundoApellido = '',
    this.FechaNacimiento = '',
    this.EstadoCivilID = '',
    this.EstadoCivil = '',
    this.IngresosMensuales = 0,
    this.TelefonoMovil = '',
    this.EscolaridadID = 0,
    this.Escolaridad = '',
    this.NombreConyuge = '',
    this.identificacionTipoId = 0,
    this.identificacionNumero = '',
    this.TelefonoDomicilio = '',
    this.CorreoElectronico = '',
    this.DependientesEconomicos = 0,
    this.Observaciones = '',
    this.edad = 0,
    this.SexoID = '',
    this.NombreCompleto = '',
    this.PagareEstatusId = 0,
    this.ProductoID = 0,
  });

  Persona.fromJson(Map<String, dynamic> json) {
    PersonaID = json['PersonaID'];
    ClienteID = json['ClienteID'];
    DistribuidorID = json['DistribuidorID'];
    CURP = json['CURP'];
    RFC = json['RFC'];
    Nombre = json['Nombre'];
    primerNombre = json['primerNombre'];
    segundoNombre = json['segundoNombre'];
    primerApellido = json['primerApellido'];
    segundoApellido = json['segundoApellido'];
    FechaNacimiento = json['FechaNacimiento'];
    EstadoCivilID = json['EstadoCivilID'];
    EstadoCivil = json['EstadoCivil'];
    IngresosMensuales = json['IngresosMensuales'];
    TelefonoMovil = json['TelefonoMovil'];
    EscolaridadID = json['EscolaridadID'];
    Escolaridad = json['Escolaridad'];
    NombreConyuge = json['NombreConyuge'];
    identificacionTipoId = json['identificacionTipoId'];
    identificacionNumero = json['identificacionNumero'];
    TelefonoDomicilio = json['TelefonoDomicilio'];
    CorreoElectronico = json['CorreoElectronico'];
    DependientesEconomicos = json['DependientesEconomicos'];
    Observaciones = json['Observaciones'];
    edad = json['edad'];
    SexoID = json['SexoID'];
    NombreCompleto = json['NombreCompleto'];
    PagareEstatusId = json['PagareEstatusId'];
    ProductoID = json['ProductoID'];
  }
}

class Direccion {
  int? DireccionID;
  int? AsentamientoID;
  String? NombreVialidad;
  String? Asentamiento;
  String? NumeroInterior;
  String? NumeroExterior;
  String? Estado;
  String? Municipio;
  String? Ciudad;
  int? CodigoPostal;
  int? vialidadTipoId;
  String? vialidadTipo;
  int? orientacionVialidadTipoId;
  String? orientacionVialidadTipo;
  String? oficina_postal;
  String? zona;
  int? ViviendaTipoId;
  String? ViviendaTipo;
  String? CreacionFecha;
  int? CreacionPersonaID;
  String? CreacionUsuarioID;
  String? ReferenciasGeograficas;
  bool? ultimaDireccion;

  Direccion({
    this.DireccionID = 0,
    this.AsentamientoID = 0,
    this.NombreVialidad = '',
    this.Asentamiento = '',
    this.NumeroInterior = '',
    this.NumeroExterior = '',
    this.Estado = '',
    this.Municipio = '',
    this.Ciudad = '',
    this.CodigoPostal = 0,
    this.vialidadTipoId = 0,
    this.vialidadTipo = '',
    this.orientacionVialidadTipoId = 0,
    this.orientacionVialidadTipo = '',
    this.oficina_postal = '',
    this.zona = '',
    this.ViviendaTipoId = 0,
    this.ViviendaTipo = '',
    this.CreacionFecha = '',
    this.CreacionPersonaID = 0,
    this.CreacionUsuarioID = '',
    this.ReferenciasGeograficas = '',
    this.ultimaDireccion = false,
  });

  Direccion.fromJson(Map<String, dynamic> json) {
    DireccionID = json['DireccionID'];
    AsentamientoID = json['AsentamientoID'];
    NombreVialidad = json['NombreVialidad'];
    Asentamiento = json['Asentamiento'];
    NumeroInterior = json['NumeroInterior'];
    NumeroExterior = json['NumeroExterior'];
    Estado = json['Estado'];
    Municipio = json['Municipio'];
    Ciudad = json['Ciudad'];
    CodigoPostal = json['CodigoPostal'];
    vialidadTipoId = json['vialidadTipoId'];
    vialidadTipo = json['vialidadTipo'];
    orientacionVialidadTipoId = json['orientacionVialidadTipoId'];
    orientacionVialidadTipo = json['orientacionVialidadTipo'];
    oficina_postal = json['oficina_postal'];
    zona = json['zona'];
    ViviendaTipoId = json['ViviendaTipoId'];
    ViviendaTipo = json['ViviendaTipo'];
    CreacionFecha = json['CreacionFecha'];
    CreacionPersonaID = json['CreacionPersonaID'];
    CreacionUsuarioID = json['CreacionUsuarioID'];
    ReferenciasGeograficas = json['ReferenciasGeograficas'];
    ultimaDireccion = json['ultimaDireccion'];
  }
}
