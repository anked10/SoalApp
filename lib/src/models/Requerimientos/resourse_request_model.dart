class ResourseRequestModel {
  String? requestDetailID;
  String? requestID;
  String? resourceID;
  String? requestDetailQuantity;
  String? requestDetailStatus;
  String? classLogisticID;
  String? businessID;
  String? measureID;
  String? resourceType;
  String? resourceName;
  String? resourceCode;
  String? resourceComent;
  String? resourcePicture;
  String? resourceStatus;
  String? measureUnidCode;
  String? measureName;
  String? measureIsActive;

  ResourseRequestModel({
    this.requestDetailID,
    this.requestID,
    this.resourceID,
    this.requestDetailQuantity,
    this.requestDetailStatus,
    this.classLogisticID,
    this.businessID,
    this.measureID,
    this.resourceType,
    this.resourceName,
    this.resourceCode,
    this.resourceComent,
    this.resourcePicture,
    this.resourceStatus,
    this.measureUnidCode,
    this.measureName,
    this.measureIsActive,
  });

  static List<ResourseRequestModel> fromJsonList(List<dynamic> json) => json.map((i) => ResourseRequestModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        'requestDetailID': requestDetailID,
        'requestID': requestID,
        'resourceID': resourceID,
        'requestDetailQuantity': requestDetailQuantity,
        'requestDetailStatus': requestDetailStatus,
        'classLogisticID': classLogisticID,
        'businessID': businessID,
        'measureID': measureID,
        'resourceType': resourceType,
        'resourceName': resourceName,
        'resourceCode': resourceCode,
        'resourceComent': resourceComent,
        'resourcePicture': resourcePicture,
        'resourceStatus': resourceStatus,
        'measureUnidCode': measureUnidCode,
        'measureName': measureName,
        'measureIsActive': measureIsActive,
      };

  factory ResourseRequestModel.fromJson(Map<String, dynamic> json) => ResourseRequestModel(
        requestDetailID: json["requestDetailID"],
        requestID: json["requestID"],
        resourceID: json["resourceID"],
        requestDetailQuantity: json["requestDetailQuantity"],
        requestDetailStatus: json["requestDetailStatus"],
        classLogisticID: json["classLogisticID"],
        businessID: json["businessID"],
        measureID: json["measureID"],
        resourceType: json["resourceType"],
        resourceName: json["resourceName"],
        resourceCode: json["resourceCode"],
        resourceComent: json["resourceComent"],
        resourcePicture: json["resourcePicture"],
        resourceStatus: json["resourceStatus"],
        measureUnidCode: json["measureUnidCode"],
        measureName: json["measureName"],
        measureIsActive: json["measureIsActive"],
      );

  factory ResourseRequestModel.fromJsonApi(Map<String, dynamic> json) => ResourseRequestModel(
        requestDetailID: json["id_requerimiento_detalle"],
        requestID: json["id_requerimiento"],
        resourceID: json["id_recurso"],
        requestDetailQuantity: json["requerimiento_detalle_cantidad"],
        requestDetailStatus: json["requerimiento_detalle_estado"],
        classLogisticID: json["id_logistica_clase"],
        businessID: json["id_empresa"],
        measureID: json["id_medida"],
        resourceType: json["recurso_tipo"],
        resourceName: json["recurso_nombre"],
        resourceCode: json["recurso_codigo"],
        resourceComent: json["recurso_comentario"],
        resourcePicture: json["recurso_foto"],
        resourceStatus: json["recurso_estado"],
        measureUnidCode: json["medida_codigo_unidad"],
        measureName: json["medida_nombre"],
        measureIsActive: json["medida_activo"],
      );
}
