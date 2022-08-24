import 'package:rxdart/rxdart.dart';
import 'package:soal_app/core/database/clases_database.dart';
import 'package:soal_app/core/database/proveedor_database.dart';
import 'package:soal_app/src/api/proveedores_api.dart';
import 'package:soal_app/src/models/materiales_proveedor_model.dart';
import 'package:soal_app/src/models/proveedores_model.dart';

class ProveedoresBloc {
  final proveedoresApi = ProveedoresApi();
  final clasesDatabase = ClasesDatabase();
  final proveedoresDatabase = ProveedoresDatabase();

  final _proveedoresController = BehaviorSubject<List<ProveedorModel>>();
  Stream<List<ProveedorModel>> get proveedoresStream => _proveedoresController.stream;

  final _materialsProveedoresController = BehaviorSubject<List<MaterialesProveedorModel>>();
  Stream<List<MaterialesProveedorModel>> get materialsProveedoresStream => _materialsProveedoresController.stream;

  final _cargandoController = BehaviorSubject<bool>();
  Stream<bool> get cargandoStream => _cargandoController.stream;

  final _cargandoMController = BehaviorSubject<bool>();
  Stream<bool> get cargandoMStream => _cargandoMController.stream;
  dispose() {
    _proveedoresController.close();
    _cargandoController.close();
    _materialsProveedoresController.close();
    _cargandoMController.close();
  }

  void obtenerProveedores() async {
    _proveedoresController.sink.add(await getProviders());
    _cargandoController.sink.add(true);
    await proveedoresApi.obtenerProveedores();
    _cargandoController.sink.add(false);
    _proveedoresController.sink.add(await getProviders());
  }

  void getMaterialsProveedoresById(String id) async {
    _materialsProveedoresController.sink.add(await proveedoresApi.materialesDatabase.getMaterialsProveedorById(id));
    _cargandoMController.sink.add(true);
    await proveedoresApi.getMaterialsProveedoresById(id);
    _cargandoMController.sink.add(false);
    _materialsProveedoresController.sink.add(await proveedoresApi.materialesDatabase.getMaterialsProveedorById(id));
  }

  Future<List<ProveedorModel>> getProviders() async {
    final List<ProveedorModel> listFinal = [];
    final providerList = await proveedoresDatabase.getProveedores();

    if (providerList.length > 0) {
      for (var i = 0; i < providerList.length; i++) {
        final clase1Dato = await clasesDatabase.getClasesForId(providerList[i].clase1.toString());
        final clase2Dato = await clasesDatabase.getClasesForId(providerList[i].clase2.toString());
        final clase3Dato = await clasesDatabase.getClasesForId(providerList[i].clase3.toString());
        final clase4Dato = await clasesDatabase.getClasesForId(providerList[i].clase4.toString());
        final clase5Dato = await clasesDatabase.getClasesForId(providerList[i].clase5.toString());
        final clase6Dato = await clasesDatabase.getClasesForId(providerList[i].clase6.toString());

        ProveedorModel proveedorModel = ProveedorModel();
        proveedorModel.idProveedor = providerList[i].idProveedor;
        proveedorModel.nombre = providerList[i].nombre;
        proveedorModel.ruc = providerList[i].ruc;
        proveedorModel.telefono = providerList[i].telefono;
        proveedorModel.estado = providerList[i].estado;
        proveedorModel.email = providerList[i].email;
        proveedorModel.direccion = providerList[i].direccion;
        proveedorModel.contacto = providerList[i].contacto;
        proveedorModel.claseGeneral = providerList[i].claseGeneral;
        proveedorModel.clase1 = (clase1Dato.length > 0) ? clase1Dato[0].logisticaClaseNombre : providerList[i].clase1;
        proveedorModel.clase2 = (clase2Dato.length > 0) ? clase2Dato[0].logisticaClaseNombre : providerList[i].clase2;
        proveedorModel.clase3 = (clase3Dato.length > 0) ? clase3Dato[0].logisticaClaseNombre : providerList[i].clase3;
        proveedorModel.clase4 = (clase4Dato.length > 0) ? clase4Dato[0].logisticaClaseNombre : providerList[i].clase4;
        proveedorModel.clase5 = (clase5Dato.length > 0) ? clase5Dato[0].logisticaClaseNombre : providerList[i].clase5;
        proveedorModel.clase6 = (clase6Dato.length > 0) ? clase6Dato[0].logisticaClaseNombre : providerList[i].clase6;
        proveedorModel.banco1 = providerList[i].banco1;
        proveedorModel.banco2 = providerList[i].banco2;
        proveedorModel.banco3 = providerList[i].banco3;

        listFinal.add(proveedorModel);
      }
    }
    return listFinal;
  }
}
