import 'package:rxdart/rxdart.dart';
import 'package:soal_app/core/database/clases_database.dart';
import 'package:soal_app/core/database/proveedor_database.dart';
import 'package:soal_app/src/models/proveedores_model.dart';

class BusquedaProveedorBloc {
  final proveedoresDatabase = ProveedoresDatabase();
  final clasesDatabase = ClasesDatabase();
  final _busquedaProveedoresController = BehaviorSubject<List<ProveedorModel>>();

  Stream<List<ProveedorModel>> get busquedaProveedoresStream => _busquedaProveedoresController.stream;

  dispose() {
    _busquedaProveedoresController.close();
  }

  void obtenerProveedorPorQueryDelivery(String query) async {
    final List<ProveedorModel> listFinal = [];

    final providerList = await proveedoresDatabase.getProveedoresQuery(query);

    if (providerList.length > 0) {
      for (int i = 0; i < providerList.length; i++) {
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

    _busquedaProveedoresController.sink.add(listFinal);
  }
}
