class DetalleOTModel {
  String? idDetalleOT;
  String? idOT;
  String? idPeriodo;
  String? diasEfectivos;
  String? diasLaborales;
  String? montoMensual;
  String? totalMensual;
  String? subTotal;
  String? total;
  String? bancoOT;
  String? cuentaOT;
  String? estadoOT;

  DetalleOTModel({
    this.idDetalleOT,
    this.idOT,
    this.idPeriodo,
    this.diasEfectivos,
    this.diasLaborales,
    this.montoMensual,
    this.totalMensual,
    this.subTotal,
    this.total,
    this.bancoOT,
    this.cuentaOT,
    this.estadoOT,
  });

  static List<DetalleOTModel> fromJsonList(List<dynamic> json) => json.map((i) => DetalleOTModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        'idDetalleOT': idDetalleOT,
        'idOT': idOT,
        'idPeriodo': idPeriodo,
        'diasEfectivos': diasEfectivos,
        'diasLaborales': diasLaborales,
        'montoMensual': montoMensual,
        'totalMensual': totalMensual,
        'subTotal': subTotal,
        'total': total,
        'bancoOT': bancoOT,
        'cuentaOT': cuentaOT,
        'estadoOT': estadoOT,
      };

  factory DetalleOTModel.fromJson(Map<String, dynamic> json) => DetalleOTModel(
        idDetalleOT: json["idDetalleOT"],
        idOT: json["idOT"],
        idPeriodo: json["idPeriodo"],
        diasEfectivos: json["diasEfectivos"],
        diasLaborales: json["diasLaborales"],
        montoMensual: json["montoMensual"],
        totalMensual: json["totalMensual"],
        subTotal: json["subTotal"],
        total: json["total"],
        bancoOT: json["bancoOT"],
        cuentaOT: json["cuentaOT"],
        estadoOT: json["estadoOT"],
      );
}
