class ObligacionTributariaModel {
  String? idObligacion;
  String? claseObligacion;
  String? codigoObligacion;
  String? yearObligacion;
  String? mesObligacion;
  String? dateCreacionObligacion;
  String? horaCreacionObligacion;
  String? dateInicioObligacion;
  String? dateFinObligacion;
  String? estadoObligacion;
  String? tipoObligacion;
  String? conceptoObligacion;
  String? activoObligacion;
  String? monedaObligacion;
  String? importeObligacion;
  String? documentacionObligacion;
  String? dateAprobacionObligacion;
  String? horaAprobacionObligacion;
  String? nombreEmpresa;
  String? rucEmpresa;
  String? direccionEmpresa;
  String? responsableEmpresa;
  String? nameCreate;
  String? surnameCreate;
  String? surnameCreate2;
  String? montoTotal;
  String? cargoEmpresa;

  ObligacionTributariaModel({
    this.idObligacion,
    this.claseObligacion,
    this.codigoObligacion,
    this.yearObligacion,
    this.mesObligacion,
    this.dateCreacionObligacion,
    this.horaCreacionObligacion,
    this.dateInicioObligacion,
    this.dateFinObligacion,
    this.estadoObligacion,
    this.tipoObligacion,
    this.conceptoObligacion,
    this.activoObligacion,
    this.monedaObligacion,
    this.importeObligacion,
    this.documentacionObligacion,
    this.dateAprobacionObligacion,
    this.horaAprobacionObligacion,
    this.nombreEmpresa,
    this.rucEmpresa,
    this.direccionEmpresa,
    this.responsableEmpresa,
    this.nameCreate,
    this.surnameCreate,
    this.surnameCreate2,
    this.montoTotal,
    this.cargoEmpresa,
  });

  static List<ObligacionTributariaModel> fromJsonList(List<dynamic> json) => json.map((i) => ObligacionTributariaModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        'idObligacion': idObligacion,
        'claseObligacion': claseObligacion,
        'codigoObligacion': codigoObligacion,
        'yearObligacion': yearObligacion,
        'mesObligacion': mesObligacion,
        'dateCreacionObligacion': dateCreacionObligacion,
        'horaCreacionObligacion': horaCreacionObligacion,
        'dateInicioObligacion': dateInicioObligacion,
        'dateFinObligacion': dateFinObligacion,
        'estadoObligacion': estadoObligacion,
        'tipoObligacion': tipoObligacion,
        'conceptoObligacion': conceptoObligacion,
        'activoObligacion': activoObligacion,
        'monedaObligacion': monedaObligacion,
        'importeObligacion': importeObligacion,
        'documentacionObligacion': documentacionObligacion,
        'dateAprobacionObligacion': dateAprobacionObligacion,
        'horaAprobacionObligacion': horaAprobacionObligacion,
        'nombreEmpresa': nombreEmpresa,
        'rucEmpresa': rucEmpresa,
        'direccionEmpresa': direccionEmpresa,
        'responsableEmpresa': responsableEmpresa,
        'nameCreate': nameCreate,
        'surnameCreate': surnameCreate,
        'surnameCreate2': surnameCreate2,
        'montoTotal': montoTotal,
        'cargoEmpresa': cargoEmpresa,
      };

  factory ObligacionTributariaModel.fromJson(Map<String, dynamic> json) => ObligacionTributariaModel(
        idObligacion: json["idObligacion"],
        claseObligacion: json["claseObligacion"],
        codigoObligacion: json["codigoObligacion"],
        yearObligacion: json["yearObligacion"],
        mesObligacion: json["mesObligacion"],
        dateCreacionObligacion: json["dateCreacionObligacion"],
        horaCreacionObligacion: json["horaCreacionObligacion"],
        dateInicioObligacion: json["dateInicioObligacion"],
        dateFinObligacion: json["dateFinObligacion"],
        estadoObligacion: json["estadoObligacion"],
        tipoObligacion: json["tipoObligacion"],
        conceptoObligacion: json["conceptoObligacion"],
        activoObligacion: json["activoObligacion"],
        monedaObligacion: json["monedaObligacion"],
        importeObligacion: json["importeObligacion"],
        documentacionObligacion: json["documentacionObligacion"],
        dateAprobacionObligacion: json["dateAprobacionObligacion"],
        horaAprobacionObligacion: json["horaAprobacionObligacion"],
        nombreEmpresa: json["nombreEmpresa"],
        rucEmpresa: json["rucEmpresa"],
        direccionEmpresa: json["direccionEmpresa"],
        responsableEmpresa: json["responsableEmpresa"],
        nameCreate: json["nameCreate"],
        surnameCreate: json["surnameCreate"],
        surnameCreate2: json["surnameCreate2"],
        montoTotal: json["montoTotal"],
        cargoEmpresa: json["cargoEmpresa"],
      );
}
