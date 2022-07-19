class RecursoDetalleOCModel {
  String? idDetalleOC;
  String? idOC;
  String? idrecurso;
  String? cantidadDetalleOC;
  String? precioUnitDetalleOC;
  String? precioUnitTDetalleOC;
  String? precioTotalDetalleOC;
  String? tipoRecurso;
  String? nombreRecurso;
  String? codigoRecurso;
  String? comentarioRecurso;
  String? umRecurso;
  String? fotoRecurso;
  String? estadoRecurso;

  RecursoDetalleOCModel({
    this.idDetalleOC,
    this.idOC,
    this.idrecurso,
    this.cantidadDetalleOC,
    this.precioUnitDetalleOC,
    this.precioUnitTDetalleOC,
    this.precioTotalDetalleOC,
    this.tipoRecurso,
    this.nombreRecurso,
    this.codigoRecurso,
    this.comentarioRecurso,
    this.umRecurso,
    this.fotoRecurso,
    this.estadoRecurso,
  });

  static List<RecursoDetalleOCModel> fromJsonList(List<dynamic> json) => json.map((i) => RecursoDetalleOCModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        'idDetalleOC': idDetalleOC,
        'idOC': idOC,
        'idrecurso': idrecurso,
        'cantidadDetalleOC': cantidadDetalleOC,
        'precioUnitDetalleOC': precioUnitDetalleOC,
        'precioUnitTDetalleOC': precioUnitTDetalleOC,
        'precioTotalDetalleOC': precioTotalDetalleOC,
        'tipoRecurso': tipoRecurso,
        'nombreRecurso': nombreRecurso,
        'codigoRecurso': codigoRecurso,
        'comentarioRecurso': comentarioRecurso,
        'umRecurso': umRecurso,
        'fotoRecurso': fotoRecurso,
        'estadoRecurso': estadoRecurso,
      };

  factory RecursoDetalleOCModel.fromJson(Map<String, dynamic> json) => RecursoDetalleOCModel(
        idDetalleOC: json["idDetalleOC"],
        idOC: json["idOC"],
        idrecurso: json["idrecurso"],
        cantidadDetalleOC: json["cantidadDetalleOC"],
        precioUnitDetalleOC: json["precioUnitDetalleOC"],
        precioUnitTDetalleOC: json["precioUnitTDetalleOC"],
        precioTotalDetalleOC: json["precioTotalDetalleOC"],
        tipoRecurso: json["tipoRecurso"],
        nombreRecurso: json["nombreRecurso"],
        codigoRecurso: json["codigoRecurso"],
        comentarioRecurso: json["comentarioRecurso"],
        umRecurso: json["umRecurso"],
        fotoRecurso: json["fotoRecurso"],
        estadoRecurso: json["estadoRecurso"],
      );
}
