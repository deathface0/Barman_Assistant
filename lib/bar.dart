import 'dart:convert';
import 'package:barman_assistant/bebida.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class BarManager {
  BarManager._();

  static final BarManager instance = BarManager._();

  Future<String> fetchData(String endpoint) async {
    try {
      final response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == HttpStatus.ok) {
        return response.body;
      } else {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al conectar con la API: $e');
    }
  }

  Future<List<Bebida>> getBebidas() async {
    final stringResponse = await fetchData('https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=Vodka');
    final Map<String, dynamic> json = jsonDecode(stringResponse);
    if (json['drinks'] != null) {
      final bebidas = <Bebida>[];
      for (var bebida in json['drinks']) {
        bebidas.add(Bebida.desdeJson(bebida));
      }
      return bebidas;
    } else {
    return [];
    }
  }
}