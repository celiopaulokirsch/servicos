import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:teste/models/result_cep.dart';

class ViaCepService {
  static Future<ResultCep> fetchCep({String cep}) async {
    final response = await http.get('https://viacep.com.br/ws/$cep/json/');
    if (response.statusCode == 200) {
      return ResultCep.fromJson(response.body);
    } else {
      Text("Requisição com erro !!!");
//      throw Exception('Requisição inválida!');
    }
  }
}
