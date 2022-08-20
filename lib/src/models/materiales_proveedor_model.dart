class MaterialesProveedorModel {
  String? idMaterial;
  String? idProveedor;
  String? idRecurso;
  String? umMaterial;
  String? solesMaterial;
  String? igvSolesMaterial;
  String? dolaresMaterial;
  String? igvDolaresMaterial;
  String? estadoMaterial;
  String? idLogisticaClase;
  String? idEmpresa;
  String? idMedida;
  String? recursoTipo;
  String? recursoNombre;
  String? recursoCodigo;
  String? recursoComentario;
  String? recursoFoto;
  String? recursoEstado;
  String? medidaCodigoUnidad;
  String? medidaNombre;
  String? medidaActivo;

  MaterialesProveedorModel({
    this.idMaterial,
    this.idProveedor,
    this.idRecurso,
    this.umMaterial,
    this.solesMaterial,
    this.igvSolesMaterial,
    this.dolaresMaterial,
    this.igvDolaresMaterial,
    this.estadoMaterial,
    this.idLogisticaClase,
    this.idEmpresa,
    this.idMedida,
    this.recursoTipo,
    this.recursoNombre,
    this.recursoCodigo,
    this.recursoComentario,
    this.recursoFoto,
    this.recursoEstado,
    this.medidaCodigoUnidad,
    this.medidaNombre,
    this.medidaActivo,
  });

  static List<MaterialesProveedorModel> fromJsonList(List<dynamic> json) => json.map((i) => MaterialesProveedorModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        'idMaterial': idMaterial,
        'idProveedor': idProveedor,
        'idRecurso': idRecurso,
        'umMaterial': umMaterial,
        'solesMaterial': solesMaterial,
        'igvSolesMaterial': igvSolesMaterial,
        'dolaresMaterial': dolaresMaterial,
        'igvDolaresMaterial': igvDolaresMaterial,
        'estadoMaterial': estadoMaterial,
        'idLogisticaClase': idLogisticaClase,
        'idEmpresa': idEmpresa,
        'idMedida': idMedida,
        'recursoTipo': recursoTipo,
        'recursoNombre': recursoNombre,
        'recursoCodigo': recursoCodigo,
        'recursoComentario': recursoComentario,
        'recursoFoto': recursoFoto,
        'recursoEstado': recursoEstado,
        'medidaCodigoUnidad': medidaCodigoUnidad,
        'medidaNombre': medidaNombre,
        'medidaActivo': medidaActivo,
      };

  factory MaterialesProveedorModel.fromJson(Map<String, dynamic> json) => MaterialesProveedorModel(
        idMaterial: json["idMaterial"],
        idProveedor: json["idProveedor"],
        idRecurso: json["idRecurso"],
        umMaterial: json["umMaterial"],
        solesMaterial: json["solesMaterial"],
        igvSolesMaterial: json["igvSolesMaterial"],
        dolaresMaterial: json["dolaresMaterial"],
        igvDolaresMaterial: json["igvDolaresMaterial"],
        estadoMaterial: json["estadoMaterial"],
        idLogisticaClase: json["idLogisticaClase"],
        idEmpresa: json["idEmpresa"],
        idMedida: json["idMedida"],
        recursoTipo: json["recursoTipo"],
        recursoNombre: json["recursoNombre"],
        recursoCodigo: json["recursoCodigo"],
        recursoComentario: json["recursoComentario"],
        recursoFoto: json["recursoFoto"],
        recursoEstado: json["recursoEstado"],
        medidaCodigoUnidad: json["medidaCodigoUnidad"],
        medidaNombre: json["medidaNombre"],
        medidaActivo: json["medidaActivo"],
      );
}
