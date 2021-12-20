class ClasesModel {
  ClasesModel({
    this.idLogisticaClase,
    this.idLogisticaTipo,
    this.logisticaClaseNombre,
  });
  String? idLogisticaClase;
  String? idLogisticaTipo;
  String? logisticaClaseNombre;

  static List<ClasesModel> fromJsonList(List<dynamic> json) => json.map((i) => ClasesModel.fromJson(i)).toList();



  Map<String, dynamic> toJson() => {
    "idLogisticaClase": idLogisticaClase,
    "idLogisticaTipo": idLogisticaTipo,
    "ruc": logisticaClaseNombre,
  };
  factory ClasesModel.fromJson(Map<String, dynamic> json) => ClasesModel(
        idLogisticaClase: json["idLogisticaClase"],
        idLogisticaTipo: json["idLogisticaTipo"],
        logisticaClaseNombre: json["logisticaClaseNombre"],
      );
}
