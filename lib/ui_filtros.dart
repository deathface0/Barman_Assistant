import 'package:flutter/material.dart';

class UI_Filtros extends StatelessWidget {
  List<String> filters;
  String filter;
  String selectedIngredient;
  final ValueChanged<String?> onBebidaClicked;

  UI_Filtros({super.key, required this.filters, required this.filter, required this.selectedIngredient, required this.onBebidaClicked,});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton(
        // Initial Value
        value: filter,
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        items: filters.map((String dropdownvalue) {
          return DropdownMenuItem(
            value: dropdownvalue,
            child: Text(dropdownvalue),
          );
        }).toList(),
        hint: const Text('Filter'),
        onChanged: onBebidaClicked,
      ),
    );
  }
}