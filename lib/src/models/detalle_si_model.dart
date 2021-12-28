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
        "recursoComentario": recursoComentario


      };
  factory DetalleSiModel.fromJson(Map<String, dynamic> json) => DetalleSiModel(
        idDetalleSi: json["idDetalleSi"],
        idSi: json["idSi"],
        idRecurso: json["idRecurso"],
        descripcion: json['descripcion'],
        
      );
}
