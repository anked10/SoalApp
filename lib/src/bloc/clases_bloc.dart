import 'package:soal_app/core/database/clases_database.dart';
import 'package:soal_app/src/models/clases_model.dart';
import 'package:rxdart/rxdart.dart';

class ClasesBloc {
  final clasesDatabase = ClasesDatabase();
  final _clasesBien1Controller = BehaviorSubject<List<ClasesModel>>();
  final _clasesBien2Controller = BehaviorSubject<List<ClasesModel>>();
  final _clasesBien3Controller = BehaviorSubject<List<ClasesModel>>();
  final _clasesServicio1Controller = BehaviorSubject<List<ClasesModel>>();
  final _clasesServicio2Controller = BehaviorSubject<List<ClasesModel>>();
  final _clasesServicio3Controller = BehaviorSubject<List<ClasesModel>>();

  Stream<List<ClasesModel>> get claseBien1 => _clasesBien1Controller.stream;
  Stream<List<ClasesModel>> get claseBien2 => _clasesBien2Controller.stream;
  Stream<List<ClasesModel>> get claseBien3 => _clasesBien3Controller.stream;
  Stream<List<ClasesModel>> get claseServicio1 => _clasesServicio1Controller.stream;
  Stream<List<ClasesModel>> get claseServicio2 => _clasesServicio2Controller.stream;
  Stream<List<ClasesModel>> get claseServicio3 => _clasesServicio3Controller.stream;

  dispose() {
    _clasesBien1Controller.close();
    _clasesBien2Controller.close();
    _clasesBien3Controller.close();
    _clasesServicio1Controller.close();
    _clasesServicio2Controller.close();
    _clasesServicio3Controller.close();
  }

  void getClaseBien1() async {
    _clasesBien1Controller.sink.add(
      await clasesDatabase.getClases(),
    );
  }

  void getClaseBien2() async {
    _clasesBien2Controller.sink.add(
      await clasesDatabase.getClases(),
    );
  }

  void getClaseBien3() async {
    _clasesBien3Controller.sink.add(
      await clasesDatabase.getClases(),
    );
  }

  void getClaseServicio1() async {
    _clasesServicio1Controller.sink.add(
      await clasesDatabase.getClases(),
    );
  }

  void getClaseServicio2() async {
    _clasesServicio2Controller.sink.add(
      await clasesDatabase.getClases(),
    );
  }

  void getClaseServicio3() async {
    _clasesServicio3Controller.sink.add(
      await clasesDatabase.getClases(),
    );
  }
}
