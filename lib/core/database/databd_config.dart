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
      db.execute(tableItemSubCategorySql);
      db.execute(tableSubCategorySql);
      db.execute(tableProductoSql);
      db.execute(tablePublicidadSql);
      //db.execute(VehiclesLocalDataSourceImpl.tableSql); */
    }, version: 1, onDowngrade: onDatabaseDowngradeDelete);
  }

  static const String tableCategoryleSql = 'CREATE TABLE Category('
      'idCategory TEXT PRIMARY KEY, '
      'categoryName TEXT, '
      'categoryEstado TEXT,'
      'categoryImage TEXT)';

  static const String tableSubCategorySql = 'CREATE TABLE SubCategory('
      'idSubCategory TEXT PRIMARY KEY, '
      'nameSubCategory TEXT, '
      'idCategory TEXT)';

  static const String tableItemSubCategorySql = 'CREATE TABLE ItemSubCategory('
      'idItemSubCategory TEXT PRIMARY KEY, '
      'nameItemSubCategory TEXT, '
      'estadoItemSubCategory TEXT,'
      'imagenItemSubCategory TEXT,'
      'idSubCategory TEXT)';

  static const String tableProductoSql = 'CREATE TABLE Producto ('
      'idProducto VARCHAR  PRIMARY KEY,'
      'idSubsidiary VARCHAR,'
      'idGood VARCHAR,'
      'idItemsubcategory VARCHAR,'
      'productoName VARCHAR,'
      'productoPrice VARCHAR,'
      'productoCurrency VARCHAR,'
      'productoImage VARCHAR,'
      'productoCharacteristics VARCHAR,'
      'productoBrand VARCHAR,'
      'productoModel VARCHAR,'
      'productoType VARCHAR,'
      'productoSize VARCHAR,'
      'productoStock VARCHAR,'
      'productoStock_status VARCHAR,'
      'productoMeasure VARCHAR,'
      'productoRating VARCHAR,'
      'productoUpdated VARCHAR,'
      'productoStatus VARCHAR,'
      'productoFavourite VARCHAR)';

  static const String tablePublicidadSql = 'CREATE TABLE Publicidad('
      'idPublicidad TEXT PRIMARY KEY, '
      'idCity TEXT, '
      'idSubsidiary TEXT,'
      'publicidadImagen TEXT,'
      'publicidadOrden TEXT,'
      'publicidadDateTime TEXT,'
      'publicidadEstado TEXT,'
      'idPago TEXT)';
}
