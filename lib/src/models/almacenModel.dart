class AlmacenModel {
  String? idAlmacen;
  String? idSede;
  String? idRecurso;
  String? almacenUnidad;
  String? almacenStock;
  String? almacenDescripcion;
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

  AlmacenModel({
    this.idAlmacen,
    this.idSede,
    this.idRecurso,
    this.almacenUnidad,
    this.almacenStock,
    this.almacenDescripcion,
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

  static List<AlmacenModel> fromJsonList(List<dynamic> json) => json.map((i) => AlmacenModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        "idAlmacen": idAlmacen,
        "idSede": idSede,
        "idRecurso": idRecurso,
        "almacenUnidad": almacenUnidad,
        "almacenStock": almacenStock,
        "almacenDescripcion": almacenDescripcion,
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
  factory AlmacenModel.fromJson(Map<String, dynamic> json) => AlmacenModel(
        idAlmacen: json["idAlmacen"],
        idSede: json["idSede"],
        idRecurso: json["idRecurso"],
        almacenUnidad: json['almacenUnidad'],
        almacenStock: json['almacenStock'],
        almacenDescripcion: json['almacenDescripcion'],
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
