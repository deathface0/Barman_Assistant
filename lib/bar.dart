import 'dart:convert';
import 'package:barman_assistant/bebida.dart';
import 'package:flutter/material.dart';
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

  Future<List<Bebida>> getBebidas(String ingrediente) async {
    final stringResponse = await fetchData('https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=$ingrediente');
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

  Future<List<Bebida>> getIngredientes() async {
    final stringResponse = await fetchData('https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list');
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

  Future<Bebida> getBebida(String nombre) async {
    final stringResponse = await fetchData('https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$nombre');
    final Map<String, dynamic> json = jsonDecode(stringResponse);
    if (json['drinks'] != null && json['drinks'] is List) {
      final Bebida bebida = Bebida.desdeJson(json['drinks'][0]);
      return bebida;
    } else {
      return Bebida(id: '', nombre: '', urlImagen: '', instrucciones: '', alcohol: '');
    }
  }
}