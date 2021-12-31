class DetalleOpModel {
  String? idDetalleOp;
  String? idOp;
  String? detalleOpPrecioUnit;
  String? detalleOpPrecioTotal;
  String? opNumero;
  String? cantidad;
  String? opVencimiento;
  String? atendido;
  String? um;
  String? descripcion;
  String? recursoTipo;
  String? recursoNombre;
  String? recursoCodigo;
  String? recursoComentario;
  String? recursoFoto;
  String? recursoEstado;
  String? proveedorNombre;
  String? proveedorRuc;
  String? proveedorDireccion;
  String? proveedorContacto;
  String? proveedorTelefono;
  String? proveedorEmail;

  DetalleOpModel({
    this.idDetalleOp,
    this.idOp,
    this.detalleOpPrecioUnit,
    this.detalleOpPrecioTotal,
    this.opNumero,
    this.cantidad,
    this.opVencimiento,
    this.atendido,
    this.um,
    this.descripcion,
    this.recursoTipo,
    this.recursoNombre,
    this.recursoCodigo,
    this.recursoComentario,
    this.recursoFoto,
    this.recursoEstado,
    this.proveedorNombre,
    this.proveedorRuc,
    this.proveedorDireccion,
    this.proveedorContacto,
    this.proveedorTelefono,
    this.proveedorEmail,
  });

  static List<DetalleOpModel> fromJsonList(List<dynamic> json) => json.map((i) => DetalleOpModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        "idDetalleOp": idDetalleOp,
        "idOp": idOp,
        "detalleOpPrecioUnit": detalleOpPrecioUnit,
        "detalleOpPrecioTotal": detalleOpPrecioTotal,
        "opNumero": opNumero,
        "cantidad": cantidad,
        "opVencimiento": opVencimiento,
        "atendido": atendido,
        "um": um,
        "descripcion": descripcion,
        "recursoTipo": recursoTipo,
        "recursoNombre": recursoNombre,
        "recursoCodigo": recursoCodigo,
        "recursoComentario": recursoComentario,
        "recursoFoto": recursoFoto,
        "recursoEstado": recursoEstado,
        "proveedorNombre": proveedorNombre,
        "proveedorRuc": proveedorRuc,
        "proveedorDireccion": proveedorDireccion,
        "proveedorContacto": proveedorContacto,
        "proveedorTelefono": proveedorTelefono,
        "proveedorEmail": proveedorEmail,
      };
  factory DetalleOpModel.fromJson(Map<String, dynamic> json) => DetalleOpModel(
        idDetalleOp: json["idDetalleOp"],
        idOp: json["idOp"],
        detalleOpPrecioUnit: json["detalleOpPrecioUnit"],
        detalleOpPrecioTotal: json['detalleOpPrecioTotal'],
        opNumero: json['opNumero'],
        cantidad: json['cantidad'],
        opVencimiento: json['opVencimiento'],
        atendido: json['atendido'],
        um: json['um'],
        descripcion: json['descripcion'],
        recursoTipo: json['recursoTipo'],
        recursoNombre: json['recursoNombre'],
        recursoCodigo: json['recursoCodigo'],
        recursoComentario: json['recursoComentario'],
        recursoFoto: json['recursoFoto'],
        recursoEstado: json['recursoEstado'],
        proveedorNombre: json['proveedorNombre'],
        proveedorRuc: json['proveedorRuc'],
        proveedorDireccion: json['proveedorDireccion'],
        proveedorContacto: json['proveedorContacto'],
        proveedorTelefono: json['proveedorTelefono'],
        proveedorEmail: json['proveedorEmail'],
      );
}
