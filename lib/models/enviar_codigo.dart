// ignore_for_file: non_constant_identifier_names

class EnviarCodigo {
  int Id;
  int PersonaID;
  String Codigo;
  String FechaEnvio;
  String FechaCaduca;
  bool Confirmado;
  int SMSId;
  int CanjeAppId;

  EnviarCodigo({
    this.Id = 0,
    this.PersonaID = 0,
    this.Codigo = '',
    this.FechaEnvio = '',
    this.FechaCaduca = '',
    this.Confirmado = false,
    this.SMSId = 0,
    this.CanjeAppId = 0,
  });

  EnviarCodigo fromJson(Map<String, dynamic> json) {
    final data = EnviarCodigo(
      Id: json['Id'],
      PersonaID: json['PersonaID'],
      Codigo: json['Codigo'],
      FechaEnvio: json['FechaEnvio'],
      FechaCaduca: json['FechaCaduca'],
      Confirmado: json['Confirmado'],
      SMSId: json['SMSId'],
      CanjeAppId: json['CanjeAppId'],
    );
    return data;
  }
}
