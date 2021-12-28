import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await getDatabase();

  Future<Database> getDatabase() async {
    final String path = join(await getDatabasesPath(), 'soalv1.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute(tableProveedorSql);
      db.execute(tableClaseSql);
      db.execute(tableSoliConmpraSql);
      db.execute(tableDetalleSoliConmpraSql);
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

  static const String tableSoliConmpraSql = 'CREATE TABLE SolicitudCompra('
      'idSi TEXT PRIMARY KEY, '
      'idSolicitante TEXT, '
      'idAprobacion TEXT, '
      'idEmpresa TEXT, '
      'idDepartamento TEXT, '
      'idSede TEXT, '
      'idProyecto TEXT, '
      'siObservaciones TEXT, '
      'siDatetime TEXT, '
      'siDatetimeAprobacion TEXT, '
      'siNumero TEXT, '
      'siEstado TEXT, '
      'siActivo TEXT, '
      'proyectoNombre TEXT, '
      'personName TEXT, '
      'personSurname TEXT, '
      'personSurname2 TEXT, '
      'sedeNombre TEXT)';

  static const String tableDetalleSoliConmpraSql = 'CREATE TABLE DetalleSoli('
      'idDetalleSi TEXT PRIMARY KEY, '
      'idSi TEXT, '
      'idRecurso TEXT, '
      'descripcion TEXT, '
      'um TEXT, '
      'cantidad TEXT, '
      'estado TEXT,'
      'atendido TEXT, '
      'cajaAlmacen TEXT, '
      'idLogisticaClase TEXT, '
      'idEmpresa TEXT, '
      'recursoTipo TEXT, '
      'recursoNombre TEXT, '
      'recursoCodigo TEXT, '
      'recursoComentario TEXT, '
      'recursoFoto TEXT, '
      'recursoEstado TEXT, '
      'idLogisticaTipo TEXT,'
      'logisticaClaseNombre TEXT,'
      'logisticaTipoNombre TEXT)';
}
