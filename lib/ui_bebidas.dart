import 'package:flutter/material.dart';
import 'bebida.dart';
import 'grid_bebidas.dart';
import 'bar.dart';

class UI_Bebidas extends StatelessWidget {
  String selectedIngredient;
  String filter;
  final ValueChanged<String> onBebidaClicked;

  UI_Bebidas({super.key, required this.selectedIngredient, required this.filter, required this.onBebidaClicked,});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BarManager.instance.getBebidas(selectedIngredient, filter),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('No se puede conectar con el servidor'),
            );
          } else if (snapshot.hasData) { // Check if data is available
            return Center(
              child: GridBebidas(
                bebidas: snapshot.data,
                onBebidaClicked: onBebidaClicked,
              ),
            );
          } else {
            return const Center(child: Text('No hay datos disponibles'));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}