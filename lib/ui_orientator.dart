import 'package:flutter/material.dart';
import 'bebida.dart';
import 'ui_filtros.dart';
import 'ui_bebidas.dart';
import 'ui_ingredientes.dart';

class UI_Orientator extends StatelessWidget {
  List<Bebida> ingredients;
  List<String> filters;
  String filter;
  String selectedIngredient;

  final ValueChanged<String?> onIngredienteClicked;
  final ValueChanged<String?> onBebidaClicked;
  final ValueChanged<String?> onFiltroClicked;

  UI_Orientator({
    super.key,
    required this.ingredients,
    required this.selectedIngredient,
    required this.filters,
    required this.filter,
    required this.onIngredienteClicked,
    required this.onBebidaClicked,
    required this.onFiltroClicked,
  });

  Column getOrientatedUI(BuildContext context, Orientation orientation)
  {
    if (orientation == Orientation.landscape)
    {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 0, // Adjust the flex value as needed
            child: UI_Filtros(
              filters: filters,
              filter: filter,
              selectedIngredient: selectedIngredient,
              onBebidaClicked: onFiltroClicked,
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 130,
                height: MediaQuery.of(context).size.height * 0.6,
                child: UI_Ingredientes(
                  ingredients: ingredients,
                  onBebidaClicked: onIngredienteClicked
                ),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: UI_Bebidas(
                    selectedIngredient: selectedIngredient,
                    filter: filter,
                    onBebidaClicked: onBebidaClicked,
                  ),
                ),
              ),

            ],
          ),
        ],
      );
    } else
    {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1, // Adjust the flex value as needed
            child: UI_Ingredientes(
              ingredients: ingredients,
              onBebidaClicked: onIngredienteClicked,
            ),
          ),
          Expanded(
            flex: 0,
            child: UI_Filtros(
              filters: filters,
              filter: filter,
              selectedIngredient: selectedIngredient,
              onBebidaClicked: onFiltroClicked,
            ),
          ),
          Expanded(
            flex: 3, // Adjust the flex value as needed
            child: UI_Bebidas(
              selectedIngredient: selectedIngredient,
              filter: filter,
              onBebidaClicked: onBebidaClicked,
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (context, orientation) {
          return getOrientatedUI(context, orientation);
        }
    );
  }
}