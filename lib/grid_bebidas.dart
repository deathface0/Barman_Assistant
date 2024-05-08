import 'package:flutter/material.dart';
import 'miniatura.dart';
import 'bebida.dart';

class GridBebidas extends StatelessWidget {
  final List<Bebida> bebidas;
  final Function(String) onBebidaClicked;

  const GridBebidas({super.key, required this.bebidas, required this.onBebidaClicked});

  bool isIngredient() => bebidas.isNotEmpty && bebidas.first.id == 'Unknown';
  int axisCount(bool isIngredient, Orientation orientation)
  {
    if (isIngredient)
    {
      return 1;
    } else {
      return orientation == Orientation.portrait ? 2 : 3;
    }
  }
  Axis getScrollDirection(Orientation orientation)
  {
    if (isIngredient()) {
      return orientation == Orientation.landscape ? Axis.horizontal : Axis.vertical;
    } else {
      return Axis.vertical;
    }
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return GridView.builder(
          scrollDirection: getScrollDirection(orientation),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: axisCount(isIngredient(), orientation),
            mainAxisExtent: 136,
          ),
          itemBuilder: (context, index) {
            return MiniaturaBebida(
              bebida: bebidas[index],
              onTap: () => onBebidaClicked(bebidas[index].nombre),
            );
          },
          itemCount: bebidas.length,
        );
      },
    );
  }
}