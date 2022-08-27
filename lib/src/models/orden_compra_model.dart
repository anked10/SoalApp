import 'package:soal_app/src/models/recurso_detalle_oc_model.dart';

class OrdenCompraNewModel {
  String? idOC;
  String? ccOC;
  String? numberOC;
  String? proformaOC;
  String? condicionPagoOC;
  String? subTotalOC;
  String? percentDescuentoOC;
  String? descuentoOC;
  String? igvOC;
  String? creditoOC;
  String? totalOC;
  String? dateTimeCreateOC;
  String? dateTimeAprobacionOC;
  String? estadoOC;
  String? activoOC;
  String? nombreProyectoOC;
  String? codigoProyectoOC;
  String? idMoneda;
  String? nameCreateOC;
  String? surnameCreateOC;
  String? surnameCreate2OC;
  String? nombreEmpresa;
  String? rucEmpresa;
  String? direccionEmpresa;
  String? nombreSede;
  String? nombreProveedor;
  String? rucProveedor;
  String? direccionProveedor;
  String? telefonoProveedor;
  String? contactoProveedor;
  String? emailProveedor;

  //NO EN DB
  List<RecursoDetalleOCModel>? recursos;

  OrdenCompraNewModel({
    this.idOC,
    this.ccOC,
    this.numberOC,
    this.proformaOC,
    this.condicionPagoOC,
    this.subTotalOC,
    this.percentDescuentoOC,
    this.descuentoOC,
    this.igvOC,
    this.creditoOC,
    this.totalOC,
    this.dateTimeCreateOC,
    this.dateTimeAprobacionOC,
    this.estadoOC,
    this.activoOC,
    this.nombreProyectoOC,
    this.codigoProyectoOC,
    this.idMoneda,
    this.nameCreateOC,
    this.surnameCreateOC,
    this.surnameCreate2OC,
    this.nombreEmpresa,
    this.rucEmpresa,
    this.direccionEmpresa,
    this.nombreSede,
    this.nombreProveedor,
    this.rucProveedor,
    this.direccionProveedor,
    this.telefonoProveedor,
    this.contactoProveedor,
    this.emailProveedor,
    this.recursos,
  });

  static List<OrdenCompraNewModel> fromJsonList(List<dynamic> json) => json.map((i) => OrdenCompraNewModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        'idOC': idOC,
        'ccOC': ccOC,
        'numberOC': numberOC,
        'proformaOC': proformaOC,
        'condicionPagoOC': condicionPagoOC,
        'subTotalOC': subTotalOC,
        'percentDescuentoOC': percentDescuentoOC,
        'descuentoOC': descuentoOC,
        'igvOC': igvOC,
        'creditoOC': creditoOC,
        'totalOC': totalOC,
        'dateTimeCreateOC': dateTimeCreateOC,
        'dateTimeAprobacionOC': dateTimeAprobacionOC,
        'estadoOC': estadoOC,
        'activoOC': activoOC,
        'nombreProyectoOC': nombreProyectoOC,
        'codigoProyectoOC': codigoProyectoOC,
        'idMoneda': idMoneda,
        'nameCreateOC': nameCreateOC,
        'surnameCreateOC': surnameCreateOC,
        'surnameCreate2OC': surnameCreate2OC,
        'nombreEmpresa': nombreEmpresa,
        'rucEmpresa': rucEmpresa,
        'direccionEmpresa': direccionEmpresa,
        'nombreSede': nombreSede,
        'nombreProveedor': nombreProveedor,
        'rucProveedor': rucProveedor,
        'direccionProveedor': direccionProveedor,
        'telefonoProveedor': telefonoProveedor,
        'contactoProveedor': contactoProveedor,
        'emailProveedor': emailProveedor,
      };

  factory OrdenCompraNewModel.fromJson(Map<String, dynamic> json) => OrdenCompraNewModel(
        idOC: json["idOC"],
        ccOC: json["ccOC"],
        numberOC: json["numberOC"],
        proformaOC: json["proformaOC"],
        condicionPagoOC: json["condicionPagoOC"],
        subTotalOC: json["subTotalOC"],
        percentDescuentoOC: json["percentDescuentoOC"],
        descuentoOC: json["descuentoOC"],
        igvOC: json["igvOC"],
        creditoOC: json["creditoOC"],
        totalOC: json["totalOC"],
        dateTimeCreateOC: json["dateTimeCreateOC"],
        dateTimeAprobacionOC: json["dateTimeAprobacionOC"],
        estadoOC: json["estadoOC"],
        activoOC: json["activoOC"],
        nombreProyectoOC: json["nombreProyectoOC"],
        codigoProyectoOC: json["codigoProyectoOC"],
        idMoneda: json["idMoneda"],
        nameCreateOC: json["nameCreateOC"],
        surnameCreateOC: json["surnameCreateOC"],
        surnameCreate2OC: json["surnameCreate2OC"],
        nombreEmpresa: json["nombreEmpresa"],
        rucEmpresa: json["rucEmpresa"],
        direccionEmpresa: json["direccionEmpresa"],
        nombreSede: json["nombreSede"],
        nombreProveedor: json["nombreProveedor"],
        rucProveedor: json["rucProveedor"],
        direccionProveedor: json["direccionProveedor"],
        telefonoProveedor: json["telefonoProveedor"],
        contactoProveedor: json["contactoProveedor"],
        emailProveedor: json["emailProveedor"],
      );
}
