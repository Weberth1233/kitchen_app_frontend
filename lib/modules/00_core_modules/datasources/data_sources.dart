import 'package:http/http.dart' as http;
import 'package:kitchen_app/modules/00_core_modules/exception/exceptions.dart';
import '../../../base_url.dart';
import 'idata_sources.dart';

class DataSources<T> implements IDatasource<T> {
  final http.Client client;

  DataSources({required this.client});

  @override
  Future<List<T>> get(String path, List<T> Function(String p1) fromJson) async {
    print('${BaseUrlApi.baseUrl}$path/');
    var url = Uri.parse('${BaseUrlApi.baseUrl}$path/');
    var response = await client.get(url);
    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      List<T> itens = fromJson(response.body);
      return itens;
    }
  }
}
