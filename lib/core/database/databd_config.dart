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
      db.execute(tableSoliConmpraSql);
      db.execute(tableDetalleSoliConmpraSql);
      db.execute(tableSedes);
      db.execute(tableAlmacen);
      db.execute(tableDocument);
      db.execute(tableOrdenCompra);
      db.execute(tableDetalleOrdenConmpraSql);
      db.execute(tableDocumentosOrdenDeCompraSql);
      db.execute(tableOrdenCompraSql);
      db.execute(tableRecursoDetalleOC);
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

  static const String tableSedes = 'CREATE TABLE Sedes('
      'idSede TEXT PRIMARY KEY, '
      'sedeNombre TEXT)';

  static const String tableAlmacen = 'CREATE TABLE Almacen('
      'idAlmacen TEXT PRIMARY KEY, '
      'idSede TEXT, '
      'idRecurso TEXT, '
      'almacenUnidad TEXT, '
      'almacenStock TEXT, '
      'almacenDescripcion TEXT, '
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

  static const String tableDocument = 'CREATE TABLE Documentos('
      'idDocumento TEXT PRIMARY KEY, '
      'idPerson TEXT, '
      'idTipo TEXT, '
      'documentoClase TEXT, '
      'documentoTipo TEXT, '
      'documentoArchivo TEXT, '
      'documentoReferencia TEXT, '
      'documentoFecha TEXT, '
      'documentoFechaSubida TEXT)';

  static const String tableOrdenCompra = 'CREATE TABLE OrdenCompra('
      'idOp TEXT PRIMARY KEY, '
      'opNumero TEXT, '
      'opVencimiento TEXT, '
      'opMoneda TEXT, '
      'opTotal TEXT, '
      'opCondiciones TEXT, '
      'opDateTime TEXT, '
      'opDateTiemAprobacion TEXT, '
      'opEstado TEXT, '
      'opActivo TEXT, '
      'proveedorNombre TEXT, '
      'personName TEXT, '
      'personSurname TEXT, '
      'personSurname2 TEXT, '
      'sedeNombre TEXT)';

  static const String tableDetalleOrdenConmpraSql = 'CREATE TABLE DetalleOr('
      'idDetalleOp TEXT PRIMARY KEY, '
      'idOp TEXT, '
      'detalleOpPrecioUnit TEXT, '
      'detalleOpPrecioTotal TEXT, '
      'opNumero TEXT, '
      'cantidad TEXT, '
      'opVencimiento TEXT,'
      'atendido TEXT, '
      'um TEXT, '
      'descripcion TEXT, '
      'recursoTipo TEXT, '
      'recursoNombre TEXT, '
      'recursoCodigo TEXT, '
      'recursoComentario TEXT, '
      'recursoFoto TEXT, '
      'recursoEstado TEXT, '
      'proveedorNombre TEXT, '
      'proveedorRuc TEXT, '
      'proveedorDireccion TEXT, '
      'proveedorContacto TEXT, '
      'proveedorTelefono TEXT, '
      'proveedorEmail TEXT)';

  static const String tableDocumentosOrdenDeCompraSql = 'CREATE TABLE DocumentosOrdenDeCompra('
      'idPago TEXT PRIMARY KEY, '
      'idObligacion TEXT, '
      'idUser TEXT, '
      'pagoBanco TEXT, '
      'pagoMoneda TEXT, '
      'pagoMonto TEXT, '
      'pagoFecha TEXT,'
      'pagoVoucher TEXT, '
      'pagoTipo TEXT, '
      'pagoReferencia TEXT, '
      'tipoComprobante TEXT, '
      'pagoRuc TEXT, '
      'pagoNroComprobante TEXT, '
      'idPersonPago TEXT, '
      'idPersonPagador TEXT, '
      'pagoRendicion TEXT, '
      'pagoRendicionAprobacion  TEXT, '
      'idOp TEXT, '
      'pagoRegCod TEXT, '
      'pagoFechaAdjuntada TEXT)';

  static const String tableOrdenCompraSql = 'CREATE TABLE OrdenCompraNew('
      'idOC TEXT PRIMARY KEY, '
      'ccOC TEXT, '
      'proformaOC TEXT, '
      'condicionPagoOC TEXT, '
      'subTotalOC TEXT, '
      'percentDescuentoOC TEXT, '
      'descuentoOC TEXT, '
      'igvOC TEXT, '
      'creditoOC TEXT, '
      'totalOC TEXT, '
      'dateTimeCreateOC TEXT,'
      'dateTimeAprobacionOC TEXT, '
      'estadoOC TEXT, '
      'activoOC TEXT, '
      'nombreProyectoOC TEXT, '
      'codigoProyectoOC TEXT, '
      'idMoneda TEXT, '
      'nameCreateOC TEXT, '
      'surnameCreateOC TEXT, '
      'surnameCreate2OC TEXT, '
      'nombreEmpresa TEXT, '
      'rucEmpresa TEXT, '
      'direccionEmpresa  TEXT, '
      'nombreSede TEXT, '
      'nombreProveedor TEXT, '
      'rucProveedor TEXT, '
      'direccionProveedor TEXT, '
      'telefonoProveedor TEXT, '
      'contactoProveedor TEXT, '
      'emailProveedor TEXT)';

  static const String tableRecursoDetalleOC = 'CREATE TABLE RecursoDetalleOC('
      'idDetalleOC TEXT PRIMARY KEY, '
      'idOC TEXT, '
      'idrecurso TEXT, '
      'cantidadDetalleOC TEXT, '
      'precioUnitDetalleOC TEXT, '
      'precioUnitTDetalleOC TEXT, '
      'precioTotalDetalleOC TEXT, '
      'tipoRecurso TEXT, '
      'nombreRecurso TEXT, '
      'codigoRecurso TEXT, '
      'comentarioRecurso TEXT, '
      'umRecurso TEXT, '
      'fotoRecurso TEXT, '
      'estadoRecurso TEXT)';
}
