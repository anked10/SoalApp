import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await getDatabase();

  Future<Database> getDatabase() async {
    final String path = join(await getDatabasesPath(), 'bufibd.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute(tableCategoryleSql);
      //db.execute(VehiclesLocalDataSourceImpl.tableSql); */
    }, version: 1, onDowngrade: onDatabaseDowngradeDelete);
  }

  static const String tableCategoryleSql = 'CREATE TABLE Proveedores('
      'idCategory TEXT PRIMARY KEY, '
      'categoryName TEXT, '
      'categoryEstado TEXT,'
      'categoryImage TEXT)';

 
}
