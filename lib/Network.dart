import 'dart:convert';

import 'package:codable/codable.dart';
import 'package:http/http.dart' as http;

enum MethodType { GET, POST, PUT }

class Network {
  static final String _baseURL = "https://api.github.com/";

  static Future<Type> request<Type extends Coding>(
      {Type entityType, MethodType methodType, String endpoint}) async {
    final url = _baseURL + endpoint;

    var response;

    switch (methodType) {
      case MethodType.GET:
        response = await http.get(url);
        break;
      case MethodType.POST:
        response = await http.post(url);
        break;
      case MethodType.PUT:
        response = await http.put(url);
        break;
    }

    final decodedJSON = json.decode(response.body);
    final transformedJSON =
        decodedJSON is List ? {"data": decodedJSON} : decodedJSON;
    final archive = KeyedArchive.unarchive(transformedJSON);
    final Type transformedResponse = entityType..decode(archive);
    return transformedResponse;
  }
}
