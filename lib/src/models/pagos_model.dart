class PagosModel {
  String? idPago;
  String? idOC;
  String? idObligacion;
  String? idUser;
  String? bancoPago;
  String? monedaPago;
  String? montoPago;
  String? fechaPago;
  String? voucherPago;
  String? tipoPago;
  String? referenciaPago;
  String? comprobanteTipo;
  String? rucPago;
  String? nroComprobantePago;
  String? rencidicionAprobacionPago;
  String? codRegPago;
  String? fechaAdjuntadaPago;
  String? nameAtended;

  PagosModel({
    this.idPago,
    this.idOC,
    this.idObligacion,
    this.idUser,
    this.bancoPago,
    this.monedaPago,
    this.montoPago,
    this.fechaPago,
    this.voucherPago,
    this.tipoPago,
    this.referenciaPago,
    this.comprobanteTipo,
    this.rucPago,
    this.nroComprobantePago,
    this.rencidicionAprobacionPago,
    this.codRegPago,
    this.fechaAdjuntadaPago,
    this.nameAtended,
  });

  static List<PagosModel> fromJsonList(List<dynamic> json) => json.map((i) => PagosModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        'idPago': idPago,
        'idOC': idOC,
        'idObligacion': idObligacion,
        'idUser': idUser,
        'bancoPago': bancoPago,
        'monedaPago': monedaPago,
        'montoPago': montoPago,
        'fechaPago': fechaPago,
        'voucherPago': voucherPago,
        'tipoPago': tipoPago,
        'referenciaPago': referenciaPago,
        'comprobanteTipo': comprobanteTipo,
        'rucPago': rucPago,
        'nroComprobantePago': nroComprobantePago,
        'rencidicionAprobacionPago': rencidicionAprobacionPago,
        'codRegPago': codRegPago,
        'fechaAdjuntadaPago': fechaAdjuntadaPago,
        'nameAtended': nameAtended,
      };

  factory PagosModel.fromJson(Map<String, dynamic> json) => PagosModel(
        idPago: json["idPago"],
        idOC: json["idOC"],
        idObligacion: json["idObligacion"],
        idUser: json["idUser"],
        bancoPago: json["bancoPago"],
        monedaPago: json["monedaPago"],
        montoPago: json["montoPago"],
        fechaPago: json["fechaPago"],
        voucherPago: json["voucherPago"],
        tipoPago: json["tipoPago"],
        referenciaPago: json["referenciaPago"],
        comprobanteTipo: json["comprobanteTipo"],
        rucPago: json["rucPago"],
        nroComprobantePago: json["nroComprobantePago"],
        rencidicionAprobacionPago: json["rencidicionAprobacionPago"],
        codRegPago: json["codRegPago"],
        fechaAdjuntadaPago: json["fechaAdjuntadaPago"],
        nameAtended: json["nameAtended"],
      );
}
