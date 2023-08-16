import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../const/api_error_helper.dart';
import '../controller/chartcontroller.dart';

class ChartService {
  Future<List<dynamic>?> chartGraphDataApi(context) async {
    final chartController =
        Provider.of<ChartController>(context, listen: false);
    chartController.loader = true;
    String url =
        'https://biapi.nve.no/magasinstatistikk/api/Magasinstatistikk/HentOffentligDataSisteUke';

    try {
      Response response = await Dio().get(url);
      if (response.statusCode == 200) {
        final result = response.data;
        chartController.loader = false;

        return result;
      }
    } on DioException catch (e) {
      chartController.loader = false;
      chartController.notifyListeners();
      ErrorHandlerCode().status401(e);
      // print(e);
    }
    return null;
  }
}
