import 'package:rxdart/rxdart.dart';
import 'package:soal_app/src/api/Request/request_api.dart';
import 'package:soal_app/src/models/Requerimientos/request_model.dart';
import 'package:soal_app/src/models/Requerimientos/resourse_request_model.dart';

class RequestBloc {
  final _api = RequestApi();

  final _requestController = BehaviorSubject<List<RequestModel>>();
  Stream<List<RequestModel>> get requestStream => _requestController.stream;

  final _resourcesRequestController = BehaviorSubject<List<ResourseRequestModel>>();
  Stream<List<ResourseRequestModel>> get resourcesStream => _resourcesRequestController;

  final _cargandoController = BehaviorSubject<bool>();
  Stream<bool> get cargandoMStream => _cargandoController.stream;

  dispose() {
    _requestController.close();
    _resourcesRequestController.close();
    _cargandoController.close();
  }

  void getRequerimentsByStatus(String status) async {
    _requestController.sink.add(await _api.requestDB.getRequetsByStatus(status));
    _cargandoController.sink.add(true);
    status == '1' ? await _api.getPendingRequest() : await _api.getApprovedRequest();
    _cargandoController.sink.add(false);
    _requestController.sink.add(await _api.requestDB.getRequetsByStatus(status));
  }

  void getDetailRequest(String requestID) async {
    _resourcesRequestController.sink.add([]);
    _resourcesRequestController.sink.add(await _api.resourceRequestDB.getResourceRequetsByIdRequest(requestID));
  }
}
