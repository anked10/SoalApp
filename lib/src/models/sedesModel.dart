class SedesModel {
  String? idSede;
  String? sedeNombre;
  SedesModel({
    this.idSede,
    this.sedeNombre,
  });

  static List<SedesModel> fromJsonList(List<dynamic> json) => json.map((i) => SedesModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        "idSede": idSede,
        "sedeNombre": sedeNombre,
      };
  factory SedesModel.fromJson(Map<String, dynamic> json) => SedesModel(
        idSede: json["idSede"],
        sedeNombre: json["sedeNombre"],
      );
}
