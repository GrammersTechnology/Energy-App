import 'package:dio/dio.dart';

import '../../../const/api_error_helper.dart';

class ChartService {
  Future<List<dynamic>?> chartGraphDataApi() async {
    String url =
        'https://biapi.nve.no/magasinstatistikk/api/Magasinstatistikk/HentOffentligDataSisteUke';

    try {
      Response response = await Dio().get(url);
      if (response.statusCode == 200) {
        final result = response.data;

        return result;
      }
    } on DioException catch (e) {
      ErrorHandlerCode().status401(e);
    }
    return null;
  }
}
