import 'package:flutter/material.dart';
import 'miniatura.dart';
import 'bebida.dart';

class GridBebidas extends StatelessWidget {
  final List<Bebida> bebidas;
  const GridBebidas({super.key, required this.bebidas});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
            mainAxisExtent: 136,
          ),
          itemBuilder: (context, index) {
            return MiniaturaBebida(bebida: bebidas[index]);
          },
          itemCount: bebidas.length,
        );
      },
    );
  }
}