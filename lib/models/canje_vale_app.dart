// ignore_for_file: non_constant_identifier_names

class CanjeValeApp {
  int VentaId;
  int Folio;
  String? Codigo;
  String CreditoId;
  String MovimientoID;
  int CanjeAppId;
  String? msj; //<<--  QUITAR

  CanjeValeApp(
      {this.VentaId = 0,
      this.Folio = 0,
      this.Codigo = '',
      this.CreditoId = '',
      this.MovimientoID = '',
      this.CanjeAppId = 0,
      this.msj = ''});

  CanjeValeApp fromJson(Map<String, dynamic> json) {
    final data = CanjeValeApp(
      VentaId: json['VentaId'],
      Folio: json['Folio'],
      Codigo: json['Codigo'],
      CreditoId: json['CreditoId'],
      MovimientoID: json['MovimientoID'],
      CanjeAppId: json['CanjeAppId'],
      msj: json['msj'],
    );
    return data;
  }
}
