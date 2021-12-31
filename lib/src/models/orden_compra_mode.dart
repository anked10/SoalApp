class OrdenCompraModel {
  String? idOp;
  String? opNumero;
  String? opVencimiento;
  String? opMoneda;
  String? opTotal;
  String? opCondiciones;
  String? opDateTime;
  String? opDateTiemAprobacion;
  String? opEstado;
  String? opActivo;
  String? proveedorNombre;
  String? personName;
  String? personSurname;
  String? personSurname2;
  String? sedeNombre;

  OrdenCompraModel({
    this.idOp,
    this.opNumero,
    this.opVencimiento,
    this.opMoneda,
    this.opTotal,
    this.opCondiciones,
    this.opDateTime,
    this.opDateTiemAprobacion,
    this.opEstado,
    this.opActivo,
    this.proveedorNombre,
    this.personName,
    this.personSurname,
    this.personSurname2,
    this.sedeNombre,
  });

  static List<OrdenCompraModel> fromJsonList(List<dynamic> json) => json.map((i) => OrdenCompraModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        "idOp": idOp,
        "opNumero": opNumero,
        "opVencimiento": opVencimiento,
        "opMoneda": opMoneda,
        "opTotal": opTotal,
        "opCondiciones": opCondiciones,
        "opDateTime": opDateTime,
        "opDateTiemAprobacion": opDateTiemAprobacion,
        "opEstado": opEstado,
        "opActivo": opActivo,
        "proveedorNombre": proveedorNombre,
        "personName": personName,
        "personSurname": personSurname,
        "personSurname2": personSurname2,
        "sedeNombre": sedeNombre,
      };
  factory OrdenCompraModel.fromJson(Map<String, dynamic> json) => OrdenCompraModel(
        idOp: json["idOp"],
        opNumero: json["opNumero"],
        opVencimiento: json["opVencimiento"],
        opMoneda: json["opMoneda"],
        opTotal: json["opTotal"],
        opCondiciones: json["opCondiciones"],
        opDateTime: json["opDateTime"],
        opDateTiemAprobacion: json["opDateTiemAprobacion"],
        opEstado: json["opEstado"],
        opActivo: json["opActivo"],
        proveedorNombre: json["proveedorNombre"],
        personName: json["personName"],
        personSurname: json["personSurname"],
        personSurname2: json["personSurname2"],
        sedeNombre: json["sedeNombre"],
      );
}
