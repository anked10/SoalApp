class DocumentsAnexadosModel {
  String? idDoc;
  String? idIncidencia;
  String? dateCreated;
  String? typeDoc;
  String? descripcionDoc;
  String? urlDoc;
  String? dateRegisterDoc;
  String? statusDoc;

  DocumentsAnexadosModel({
    this.idDoc,
    this.idIncidencia,
    this.dateCreated,
    this.typeDoc,
    this.descripcionDoc,
    this.urlDoc,
    this.dateRegisterDoc,
    this.statusDoc,
  });

  static List<DocumentsAnexadosModel> fromJsonList(List<dynamic> json) => json.map((i) => DocumentsAnexadosModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        'idDoc': idDoc,
        'idIncidencia': idIncidencia,
        'dateCreated': dateCreated,
        'typeDoc': typeDoc,
        'descripcionDoc': descripcionDoc,
        'urlDoc': urlDoc,
        'dateRegisterDoc': dateRegisterDoc,
        'statusDoc': statusDoc,
      };

  factory DocumentsAnexadosModel.fromJson(Map<String, dynamic> json) => DocumentsAnexadosModel(
        idDoc: json["idDoc"],
        idIncidencia: json["idIncidencia"],
        dateCreated: json["dateCreated"],
        typeDoc: json["typeDoc"],
        descripcionDoc: json["descripcionDoc"],
        urlDoc: json["urlDoc"],
        dateRegisterDoc: json["dateRegisterDoc"],
        statusDoc: json["statusDoc"],
      );

  factory DocumentsAnexadosModel.fromJson2(Map<String, dynamic> json) => DocumentsAnexadosModel(
        idDoc: json["id_documento"],
        idIncidencia: json["id_incidencia"],
        dateCreated: json["documento_fecha_creacion"],
        typeDoc: json["documento_tipo"],
        descripcionDoc: json["documento_descripcion"],
        urlDoc: json["documento_adjuntado"],
        dateRegisterDoc: json["documento_fecha_registro"],
        statusDoc: json["documento_estado"],
      );
}
