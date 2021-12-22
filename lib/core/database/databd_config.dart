import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await getDatabase();

  Future<Database> getDatabase() async {
    final String path = join(await getDatabasesPath(), 'soal.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute(tableProveedorSql);
      db.execute(tableClaseSql);
      //db.execute(VehiclesLocalDataSourceImpl.tableSql); */
    }, version: 1, onDowngrade: onDatabaseDowngradeDelete);
  }

  static const String tableProveedorSql = 'CREATE TABLE Proveedores('
      'idProveedor TEXT PRIMARY KEY, '
      'nombre TEXT, '
      'ruc TEXT,'
      'direccion TEXT,'
      'telefono TEXT,'
      'contacto TEXT,'
      'email TEXT,'
      'clase1 TEXT,'
      'clase2 TEXT,'
      'clase3 TEXT,'
      'clase4 TEXT,'
      'clase5 TEXT,'
      'clase6 TEXT,'
      'claseGeneral TEXT,'
      'banco1 TEXT,'
      'banco2 TEXT,'
      'banco3 TEXT,'
      'estado TEXT)';

  static const String tableClaseSql = 'CREATE TABLE Clase('
      'idLogisticaClase TEXT PRIMARY KEY, '
      'idLogisticaTipo TEXT,'
      'logisticaClaseNombre TEXT)';

       static const String tableBancosSql = 'CREATE TABLE Bancos('
      'idBanco TEXT PRIMARY KEY, '
      'bancoNombre TEXT)';

       static const String tableMonedaSql = 'CREATE TABLE Monedas('
      'idMoneda TEXT PRIMARY KEY, '
      'monedaNombre TEXT)';
}


/*

// To parse this JSON data, do
//
//     final bancos = bancosFromJson(jsonString);

import 'dart:convert';

Bancos bancosFromJson(String str) => Bancos.fromJson(json.decode(str));

String bancosToJson(Bancos data) => json.encode(data.toJson());

class Bancos {
    Bancos({
        this.result,
    });

    Result result;

    factory Bancos.fromJson(Map<String, dynamic> json) => Bancos(
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "result": result.toJson(),
    };
}

class Result {
    Result({
        this.code,
        this.bancos,
        this.monedas,
    });

    int code;
    List<String> bancos;
    List<String> monedas;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        code: json["code"],
        bancos: List<String>.from(json["bancos"].map((x) => x)),
        monedas: List<String>.from(json["monedas"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "bancos": List<dynamic>.from(bancos.map((x) => x)),
        "monedas": List<dynamic>.from(monedas.map((x) => x)),
    };
}


 */