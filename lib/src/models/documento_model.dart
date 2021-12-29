class DocumentoModel {
  DocumentoModel({
    this.idDocumento,
    this.idPerson,
    this.idTipo,
    this.documentoClase,
    this.documentoTipo,
    this.documentoArchivo,
    this.documentoReferencia,
    this.documentoFecha,
    this.documentoFechaSubida,
  });

  String? idDocumento;
  String? idPerson;
  String? idTipo;
  String? documentoClase;
  String? documentoTipo;
  String? documentoArchivo;
  String? documentoReferencia;
  String? documentoFecha;
  String? documentoFechaSubida;




  static List<DocumentoModel> fromJsonList(List<dynamic> json) => json.map((i) => DocumentoModel.fromJson(i)).toList();



  Map<String, dynamic> toJson() => {
    "idDocumento": idDocumento,
    "idPerson": idPerson,
    "idTipo": idTipo,
    "documentoClase": documentoClase,
    "documentoTipo": documentoTipo,
    "documentoArchivo": documentoArchivo,
    "documentoReferencia": documentoReferencia,
    "documentoFecha": documentoFecha,
    "documentoFechaSubida": documentoFechaSubida,
  };
  factory DocumentoModel.fromJson(Map<String, dynamic> json) => DocumentoModel(
        idDocumento: json["idDocumento"],
        idPerson: json["idPerson"],
        idTipo: json["idTipo"],
        documentoClase: json["documentoClase"],
        documentoTipo: json["documentoTipo"],
        documentoArchivo: json["documentoArchivo"],
        documentoReferencia: json["documentoReferencia"],
        documentoFecha: json["documentoFecha"],
        documentoFechaSubida: json["documentoFechaSubida"],
      );
}

