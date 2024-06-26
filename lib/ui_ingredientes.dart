import 'package:flutter/material.dart';
import 'bebida.dart';
import 'grid_bebidas.dart';

class UI_Ingredientes extends StatelessWidget {
  List<Bebida> ingredients;
  final ValueChanged<String> onBebidaClicked;

  UI_Ingredientes({super.key, required this.ingredients, required this.onBebidaClicked,});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridBebidas(
        bebidas: ingredients,
        onBebidaClicked: onBebidaClicked,
      ),
    );
  }
}