import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soal_app/src/models/api_result_model.dart';

class ConsultaRucApi {
  Future<ApiResultModel> searchRUC(String ruc) async {
    ApiResultModel result = ApiResultModel();
    try {
      final url = 'https://api.migo.pe/api/v1/ruc';
      String token = 'uTZu2aTvMPpqWFuzKATPRWNujUUe7Re1scFlRsTy9Q15k1sjdJVAc9WGy57m';
      final response = await http.post(Uri.parse(url),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'token': token,
            'ruc': ruc,
          }));

      final decodedData = json.decode(response.body);
      if (response.statusCode == 200) {
        result.code = 200;
        result.message = 'RUC validado. ${decodedData['nombre_o_razon_social']}';
      } else {
        result.code = 2;
        result.message = 'Inténtelo Nuevamente';
      }

      return result;
    } catch (e) {
      print(e);
      result.code = 2;
      result.message = 'Ocurrió un error';
      return result;
    }
  }
}
