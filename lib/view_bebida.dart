import 'package:flutter/material.dart';
import 'bebida.dart';
import 'bar.dart';

class ViewBebida extends StatelessWidget {
  String nombre;
  Bebida _bebida;

  ViewBebida({super.key, required this.nombre}) :
        _bebida = Bebida(id: '', nombre: nombre, urlImagen: '', instrucciones: '');

  @override
  Widget build(BuildContext context) {
    final future = FutureBuilder(
      future: BarManager.instance.getBebida(nombre),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return  Center(
              child: Text('No se puede conectar con el servidor $nombre'),
            );
          } else if (snapshot.hasData) { // Check if data is available
            _bebida = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 40),
                Image.network(
                  _bebida.urlImagen,
                  width: 300, // Adjust the width as needed
                  height: 300, // Adjust the height as needed
                ),
                const SizedBox(height: 20), // Add spacing between image and text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0), // Set left and right padding
                  child: Text(
                    _bebida.nombre,
                    textAlign: TextAlign.justify, // Set text alignment to justify
                    style: const TextStyle(
                      fontSize: 20, // Adjust the font size as needed
                      fontWeight: FontWeight.bold, // Adjust the font weight as needed
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Add spacing between image and text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0), // Set left and right padding
                  child: Text(
                    _bebida.instrucciones,
                    textAlign: TextAlign.justify, // Set text alignment to justify
                    style: const TextStyle(
                      fontSize: 20, // Adjust the font size as needed
                      fontWeight: FontWeight.normal, // Adjust the font weight as needed
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No hay datos disponibles'));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(nombre),
      ),
      body: Center(
        child: future
      ),
    );
  }
}