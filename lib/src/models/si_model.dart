class SiModel {
  String? idSi;
  String? idSolicitante;
  String? idAprobacion;
  String? idEmpresa;
  String? idDepartamento;
  String? idSede;
  String? idProyecto;
  String? siObservaciones;
  String? siDatetime;
  String? siDatetimeAprobacion;
  String? siNumero;
  String? siEstado;
  String? siActivo;
  String? proyectoNombre;
  String? personName;
  String? personSurname;
  String? personSurname2;
  String? sedeNombre;

  SiModel(
      {this.idSi,
      this.idSolicitante,
      this.idAprobacion,
      this.idEmpresa,
      this.idDepartamento,
      this.idSede,
      this.idProyecto,
      this.siObservaciones,
      this.siDatetime,
      this.siDatetimeAprobacion,
      this.siNumero,
      this.siEstado,
      this.siActivo,
      this.proyectoNombre,
      this.personName,
      this.personSurname,
      this.personSurname2,
      this.sedeNombre});

  static List<SiModel> fromJsonList(List<dynamic> json) => json.map((i) => SiModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        "idSi": idSi,
        "idSolicitante": idSolicitante,
        "idAprobacion": idAprobacion,
        "idEmpresa": idEmpresa,
        "idDepartamento": idDepartamento,
        "idSede": idSede,
        "idProyecto": idProyecto,
        "siObservaciones": siObservaciones,
        "siDatetime": siDatetime,
        "siDatetimeAprobacion": siDatetimeAprobacion,
        "siNumero": siNumero,
        "siEstado": siEstado,
        "siActivo": siActivo,
        "proyectoNombre": proyectoNombre,
        "personName": personName,
        "personSurname": personSurname,
        "personSurname2": personSurname2,
        "sedeNombre": sedeNombre,
      };
  factory SiModel.fromJson(Map<String, dynamic> json) => SiModel(
        idSi: json["idSi"],
        idSolicitante: json["idSolicitante"],
        idAprobacion: json["idAprobacion"],
        idEmpresa: json["idEmpresa"],
        idDepartamento: json["idDepartamento"],
        idSede: json["idSede"],
        idProyecto: json["idProyecto"],
        siObservaciones: json["siObservaciones"],
        siDatetime: json["siDatetime"],
        siDatetimeAprobacion: json["siDatetimeAprobacion"],
        siNumero: json["siNumero"],
        siEstado: json["siEstado"],
        siActivo: json["siActivo"],
        proyectoNombre: json["proyectoNombre"],
        personName: json["personName"],
        personSurname: json["personSurname"],
        personSurname2: json["personSurname2"],
        sedeNombre: json["sedeNombre"],
      );
}
