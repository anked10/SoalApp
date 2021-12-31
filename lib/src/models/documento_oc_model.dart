class DocumentoOCModel {
  String? idPago;
  String? idObligacion;
  String? idUser;
  String? pagoBanco;
  String? pagoMoneda;
  String? pagoMonto;
  String? pagoFecha;
  String? pagoVoucher;
  String? pagoTipo;
  String? pagoReferencia;
  String? tipoComprobante;
  String? pagoRuc;
  String? pagoNroComprobante;
  String? idPersonPago;
  String? idPersonPagador;
  String? pagoRendicion;
  String? pagoRendicionAprobacion;
  String? idOp;
  String? pagoRegCod;
  String? pagoFechaAdjuntada;

  DocumentoOCModel({
    this.idPago,
    this.idObligacion,
    this.idUser,
    this.pagoBanco,
    this.pagoMoneda,
    this.pagoMonto,
    this.pagoFecha,
    this.pagoVoucher,
    this.pagoTipo,
    this.pagoReferencia,
    this.tipoComprobante,
    this.pagoRuc,
    this.pagoNroComprobante,
    this.idPersonPago,
    this.idPersonPagador,
    this.pagoRendicion,
    this.pagoRendicionAprobacion,
    this.idOp,
    this.pagoRegCod,
    this.pagoFechaAdjuntada,
  });


  static List<DocumentoOCModel> fromJsonList(List<dynamic> json) => json.map((i) => DocumentoOCModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
    "idPago": idPago,
    "idObligacion": idObligacion,
    "idUser": idUser,
    "pagoBanco": pagoBanco,
    "pagoMoneda": pagoMoneda,
    "pagoMonto": pagoMonto,
    "pagoFecha": pagoFecha,
    "pagoVoucher": pagoVoucher,
    "pagoTipo": pagoTipo,
    "pagoReferencia": pagoReferencia,
    "tipoComprobante": tipoComprobante,
    "pagoRuc": pagoRuc,
    "pagoNroComprobante": pagoNroComprobante,
    "idPersonPago": idPersonPago,
    "idPersonPagador": idPersonPagador,
    "pagoRendicion": pagoRendicion,
    "pagoRendicionAprobacion": pagoRendicionAprobacion,
    "idOp": idOp,
    "pagoRegCod": pagoRegCod,
    "pagoFechaAdjuntada": pagoFechaAdjuntada,
  };
  factory DocumentoOCModel.fromJson(Map<String, dynamic> json) => DocumentoOCModel(
        idPago: json["idPago"],
        idObligacion: json["idObligacion"],
        idUser: json["idUser"],
        pagoBanco: json["pagoBanco"],
        pagoMoneda: json["pagoMoneda"],
        pagoMonto: json["pagoMonto"],
        pagoFecha: json["pagoFecha"],
        pagoVoucher: json["pagoVoucher"],
        pagoTipo: json["pagoTipo"],
        pagoReferencia: json["pagoReferencia"],
        tipoComprobante: json["tipoComprobante"],
        pagoRuc: json["pagoRuc"],
        pagoNroComprobante: json["pagoNroComprobante"],
        idPersonPago: json["idPersonPago"],
        idPersonPagador: json["idPersonPagador"],
        pagoRendicion: json["pagoRendicion"],
        pagoRendicionAprobacion: json["pagoRendicionAprobacion"],
        idOp: json["idOp"],
        pagoRegCod: json["pagoRegCod"],
        pagoFechaAdjuntada: json["pagoFechaAdjuntada"],
      );
}
