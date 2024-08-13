import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../base_url.dart';
import '../../exception/exceptions.dart';
import 'idata_sources.dart';

class DataSources<T> implements IDatasource<T> {
  final http.Client client;

  DataSources({required this.client});

  @override
  Future<List<T>> get(String path, List<T> Function(String p1) fromJson) async {
    var url = Uri.parse('${BaseUrlApi.baseUrl}$path');
    var response = await client.get(
      url,
    );
    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      var responseBody = utf8.decode(response.bodyBytes);
      List<T> itens = fromJson(responseBody);
      return itens;
    }
  }

  @override
  Future<List<T>> getPaginated(String path,
      List<T> Function(String p1) fromJson, Map<String, dynamic> params) async {
    var url = Uri.parse('${BaseUrlApi.baseUrl}$path');
    String data = jsonEncode(params);
    var response = await client.post(
      url,
      headers: {
        'Content-Type':
            'application/json', // Defina o tipo de conteúdo como JSON
      },
      body: data,
    );
    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      var responseBody = utf8.decode(response.bodyBytes);
      List<T> itens = fromJson(responseBody);
      return itens;
    }
  }

  @override
  Future<T> getEntity(
      String path, T Function(Map<String, dynamic> json) fromJson) async {
    var url = Uri.parse('${BaseUrlApi.baseUrl}$path');
    var response = await client.get(
      url,
    );
    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      var responseBody = utf8.decode(response.bodyBytes);
      var decodedJson = json.decode(responseBody) as Map<String, dynamic>;
      T item = fromJson(decodedJson);
      return item;
    }
  }
}
