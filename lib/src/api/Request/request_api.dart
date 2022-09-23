import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soal_app/core/database/Request/request_database.dart';
import 'package:soal_app/core/database/Request/resource_request_database.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/src/models/Requerimientos/request_model.dart';
import 'package:soal_app/src/models/Requerimientos/resourse_request_model.dart';

class RequestApi {
  final requestDB = RequestDatabase();
  final resourceRequestDB = ResourceRequestDatabase();

  Future<int> getApprovedRequest() async {
    try {
      final url = '$API_BASE_URL/api/Requerimiento/ws_requerimientos_aprobados';
      String? token = await StorageManager.readData('token');
      final response = await http.post(Uri.parse(url), body: {
        'app': 'true',
        'tn': token,
      });

      if (response.statusCode == 200) {
        await requestDB.deleteByStatus('1');
        await resourceRequestDB.deleteByStatus('1');
        final decodedData = json.decode(response.body);
        for (var i = 0; i < decodedData["result"]["aprobados"].length; i++) {
          requestDB.insertRequest(RequestModel.fromJsonApi(decodedData["result"]["aprobados"][i]));
          for (var x = 0; x < decodedData["result"]["aprobados"][i]["detalle_requerimiento"].length; x++) {
            resourceRequestDB
                .insertResourceRequest(ResourseRequestModel.fromJsonApi(decodedData["result"]["aprobados"][i]["detalle_requerimiento"][x]));
          }
        }
      }

      return 1;
    } catch (e) {
      print(e);
      return 2;
    }
  }
}
