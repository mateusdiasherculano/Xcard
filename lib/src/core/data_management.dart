import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/card_model.dart';

class DataManagement {
  Future<List<CardModel>> getCardModels() async {
    // Lógica para buscar os modelos de cartão do banco de dados e retornar a lista de CardModel
    // Exemplo:
    final response =
        await http.get(Uri.parse('URL_DO_SEU_ENDPOINT_DE_MODELOS_DE_CARTAO'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((item) => CardModel(id: item['id'], name: item['name']))
          .toList();
    } else {
      throw Exception('Falha ao buscar os modelos de cartão');
    }
  }

  Future<List<String>> getCities() async {
    // Lógica para buscar as cidades do banco de dados e retornar a lista de strings
    // Exemplo:
    final response =
        await http.get(Uri.parse('URL_DO_SEU_ENDPOINT_DE_CIDADES'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => item['name'].toString()).toList();
    } else {
      throw Exception('Falha ao buscar as cidades');
    }
  }

  Future<List<String>> getSexes() async {
    // Lógica para buscar os sexos do banco de dados e retornar a lista de strings
    // Exemplo:
    final response = await http.get(Uri.parse('URL_DO_SEU_ENDPOINT_DE_SEXOS'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => item['name'].toString()).toList();
    } else {
      throw Exception('Falha ao buscar os sexos');
    }
  }
}
