class DetalleSiModel {
  String? idDetalleSi;
  String? idSi;
  String? idRecurso;
  String? descripcion;
  String? um;
  String? cantidad;
  String? estado;
  String? atendido;
  String? cajaAlmacen;
  String? idLogisticaClase;
  String? idEmpresa;
  String? recursoTipo;
  String? recursoNombre;
  String? recursoCodigo;
  String? recursoComentario;
  String? recursoFoto;
  String? recursoEstado;
  String? idLogisticaTipo;
  String? logisticaClaseNombre;
  String? logisticaTipoNombre;

  DetalleSiModel({
    this.idDetalleSi,
    this.idSi,
    this.idRecurso,
    this.descripcion,
    this.um,
    this.cantidad,
    this.estado,
    this.atendido,
    this.cajaAlmacen,
    this.idLogisticaClase,
    this.idEmpresa,
    this.recursoTipo,
    this.recursoNombre,
    this.recursoCodigo,
    this.recursoComentario,
    this.recursoFoto,
    this.recursoEstado,
    this.idLogisticaTipo,
    this.logisticaClaseNombre,
    this.logisticaTipoNombre,
  });

  static List<DetalleSiModel> fromJsonList(List<dynamic> json) => json.map((i) => DetalleSiModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        "idDetalleSi": idDetalleSi,
        "idSi": idSi,
        "idRecurso": idRecurso,
        "descripcion": descripcion,
        "um": um,
        "cantidad":cantidad,
        "estado":estado,
        "atendido": atendido,
        "cajaAlmacen": cajaAlmacen,
        "idLogisticaClase": idLogisticaClase,
        "idEmpresa": idEmpresa,
        "recursoTipo": recursoTipo,
        "recursoNombre": recursoNombre,
        "recursoCodigo": recursoCodigo,
        "recursoComentario": recursoComentario,
        "recursoFoto": recursoFoto,
        "recursoEstado": recursoEstado,
        "idLogisticaTipo": idLogisticaTipo,
        "logisticaClaseNombre": logisticaClaseNombre,
        "logisticaTipoNombre": logisticaTipoNombre


      };
  factory DetalleSiModel.fromJson(Map<String, dynamic> json) => DetalleSiModel(
        idDetalleSi: json["idDetalleSi"],
        idSi: json["idSi"],
        idRecurso: json["idRecurso"],
        descripcion: json['descripcion'],
        um:json['um'],
        cantidad: json['cantidad'],
        estado: json['estado'],
        atendido: json['atendido'],
        cajaAlmacen: json['cajaAlmacen'],
        idLogisticaClase: json['idLogisticaClase'],
        idEmpresa: json['idEmpresa'],
        recursoTipo: json['recursoTipo'],
        recursoNombre: json['recursoNombre'],
        recursoCodigo: json['recursoCodigo'],
        recursoComentario: json['recursoComentario'],
        recursoFoto: json['recursoFoto'],
        recursoEstado: json['recursoEstado'],
        idLogisticaTipo: json['idLogisticaTipo'],
        logisticaClaseNombre: json['logisticaClaseNombre'],
        logisticaTipoNombre: json['logisticaTipoNombre'],

      );
}
