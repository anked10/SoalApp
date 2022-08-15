import 'package:rxdart/rxdart.dart';
import 'package:soal_app/core/database/Menu/modulo_database.dart';
import 'package:soal_app/core/database/Menu/submodulo_database.dart';
import 'package:soal_app/src/models/Menu/modulos_model.dart';
import 'package:soal_app/src/models/Menu/submodulo_model.dart';

class ModulosBloc {
  final _moduloDB = ModuloDatabase();
  final _submoduloDB = SubModuloDatabase();
  final _modulosController = BehaviorSubject<List<ModulosModel>>();
  Stream<List<ModulosModel>> get modulosStream => _modulosController.stream;

  dispose() {
    _modulosController.close();
  }

  void getModulosUser() async {
    _modulosController.sink.add(await modulos());
  }

  Future<List<ModulosModel>> modulos() async {
    final List<ModulosModel> result = [];

    final modulos = await _moduloDB.getModulos();

    for (var i = 0; i < modulos.length; i++) {
      final List<SubModuloModel> list = [];
      final subModulos = await _submoduloDB.getSubModulosByIdModulo(modulos[i].idModulo.toString());

      for (var x = 0; x < subModulos.length; x++) {
        list.add(subModulos[x]);
      }

      if (list.isNotEmpty) {
        final modulo = ModulosModel();

        modulo.idModulo = modulos[i].idModulo;
        modulo.nombreModulo = modulos[i].nombreModulo;
        modulo.ordenModulo = modulos[i].ordenModulo;
        modulo.estadoModulo = modulos[i].estadoModulo;
        modulo.visibleAppModulo = modulos[i].visibleAppModulo;
        modulo.subModulos = list;

        result.add(modulo);
      }
    }

    return result;
  }

  void deleteAll() async {
    await _moduloDB.deleteModulos();
    await _submoduloDB.deleteSubModulos();
  }
}
