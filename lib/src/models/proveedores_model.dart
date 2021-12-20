class ProveedorModel {
  ProveedorModel({
    this.idProveedor,
    this.nombre,
    this.ruc,
    this.direccion,
    this.telefono,
    this.contacto,
    this.email,
    this.clase1,
    this.clase2,
    this.clase3,
    this.clase4,
    this.clase5,
    this.clase6,
    this.claseGeneral,
    this.banco1,
    this.banco2,
    this.banco3,
    this.estado,
  });
  String? idProveedor;
  String? nombre;
  String? ruc;
  String? direccion;
  String? telefono;
  String? contacto;
  String? email;
  String? clase1;
  String? clase2;
  String? clase3;
  String? clase4;
  String? clase5;
  String? clase6;
  String? claseGeneral;
  String? banco1;
  String? banco2;
  String? banco3;
  String? estado;

  static List<ProveedorModel> fromJsonList(List<dynamic> json) => json.map((i) => ProveedorModel.fromJson(i)).toList();



  Map<String, dynamic> toJson() => {
    "idProveedor": idProveedor,
    "nombre": nombre,
    "ruc": ruc,
    "direccion": direccion,
    "telefono": telefono,
    "contacto": contacto,
    "email": email,
    "clase1": clase1,
    "clase2": clase2,
    "clase3": clase3,
    "clase4": clase4,
    "clase5": clase5,
    "clase6": clase6,
    "claseGeneral": claseGeneral,
    "banco1": banco1,
    "banco2": banco2,
    "banco3": banco3,
    "estado": estado,
  };
  factory ProveedorModel.fromJson(Map<String, dynamic> json) => ProveedorModel(
        idProveedor: json["idProveedor"],
        nombre: json["nombre"],
        ruc: json["ruc"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        contacto: json["contacto"],
        email: json["email"],
        clase1: json["clase1"],
        clase2: json["clase2"],
        clase3: json["clase3"],
        clase4: json["clase4"],
        clase5: json["clase5"],
        clase6: json["clase6"],
        claseGeneral: json["claseGeneral"],
        banco1: json["banco1"],
        banco2: json["banco2"],
        banco3: json["banco3"],
        estado: json["estado"],
      );
}
