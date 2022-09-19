class RequerimientosModel {
  String? requestID;
  String? businessID;
  String? proyectID;
  String? userID;
  String? requestCode;
  String? requestDate;
  String? requestDateTime;
  String? requestStatus;
  String? userAprobeID;
  String? userAprobeName;
  String? requestDateTimeAprobe;
  String? businessName;
  String? businessRUC;
  String? businessAddress;
  String? proyectName;
  String? proyectCode;
  String? proyectDateStart;
  String? proyectDateEnd;
  String? personCreatedName;

  RequerimientosModel({
    this.requestID,
    this.businessID,
    this.proyectID,
    this.userID,
    this.requestCode,
    this.requestDate,
    this.requestDateTime,
    this.requestStatus,
    this.userAprobeID,
    this.userAprobeName,
    this.requestDateTimeAprobe,
    this.businessName,
    this.businessRUC,
    this.businessAddress,
    this.proyectName,
    this.proyectCode,
    this.proyectDateStart,
    this.proyectDateEnd,
    this.personCreatedName,
  });

  static List<RequerimientosModel> fromJsonList(List<dynamic> json) => json.map((i) => RequerimientosModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        'requestID': requestID,
        'businessID': businessID,
        'proyectID': proyectID,
        'userID': userID,
        'requestCode': requestCode,
        'requestDate': requestDate,
        'requestDateTime': requestDateTime,
        'requestStatus': requestStatus,
        'userAprobeID': userAprobeID,
        'userAprobeName': userAprobeName,
        'requestDateTimeAprobe': requestDateTimeAprobe,
        'businessName': businessName,
        'businessRUC': businessRUC,
        'businessAddress': businessAddress,
        'proyectName': proyectName,
        'proyectCode': proyectCode,
        'proyectDateStart': proyectDateStart,
        'proyectDateEnd': proyectDateEnd,
        'personCreatedName': personCreatedName,
      };

  factory RequerimientosModel.fromJson(Map<String, dynamic> json) => RequerimientosModel(
        requestID: json["requestID"],
        businessID: json["businessID"],
        proyectID: json["proyectID"],
        userID: json["userID"],
        requestCode: json["requestCode"],
        requestDate: json["requestDate"],
        requestDateTime: json["requestDateTime"],
        requestStatus: json["requestStatus"],
        userAprobeID: json["userAprobeID"],
        userAprobeName: json["userAprobeName"],
        requestDateTimeAprobe: json["requestDateTimeAprobe"],
        businessName: json["businessName"],
        businessRUC: json["businessRUC"],
        businessAddress: json["businessAddress"],
        proyectName: json["proyectName"],
        proyectCode: json["proyectCode"],
        proyectDateStart: json["proyectDateStart"],
        proyectDateEnd: json["proyectDateEnd"],
        personCreatedName: json["personCreatedName"],
      );

  factory RequerimientosModel.fromJsonApi(Map<String, dynamic> json) => RequerimientosModel(
        requestID: json["id_requerimiento"],
        businessID: json["id_empresa"],
        proyectID: json["id_proyecto"],
        userID: json["id_usuario"],
        requestCode: json["requerimiento_codigo"],
        requestDate: json["requerimiento_fecha"],
        requestDateTime: json["requerimiento_datetime"],
        requestStatus: json["requerimiento_estado"],
        userAprobeID: json["id_usuario_aprobacion"],
        userAprobeName: json["  "],
        requestDateTimeAprobe: json["requerimiento_datetime_aprobacion"],
        businessName: json["empresa"],
        businessRUC: json["empresa_ruc"],
        businessAddress: json["empresa_direccion"],
        proyectName: json["proyecto"],
        proyectCode: json["proyecto_codigo"],
        proyectDateStart: json["proyecto_inicio"],
        proyectDateEnd: json["proyecto_fin"],
        personCreatedName: json["generado_por"],
      );
}
