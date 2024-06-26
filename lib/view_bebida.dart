import 'package:flutter/material.dart';
import 'bebida.dart';
import 'bar.dart';

class ViewBebida extends StatelessWidget {
  String nombre;
  Bebida _bebida;

  ViewBebida({super.key, required this.nombre}) :
        _bebida = Bebida(id: '', nombre: nombre, urlImagen: '', instrucciones: '');

  Column getOrientatedUI(BuildContext context, Orientation orientation)
  {
    if (orientation == Orientation.landscape)
    {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10.0, top: 15.0),
                child: Image.network(
                  _bebida.urlImagen,
                  width: 300,
                  height: MediaQuery.of(context).size.height * 0.7,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _bebida.nombre,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.55,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: SingleChildScrollView(
                      child: Text(
                        _bebida.instrucciones,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    } else
    {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 40),
          Image.network(
            _bebida.urlImagen,
            width: 300,
            height: 300,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              _bebida.nombre,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: SingleChildScrollView(
                child: Text(
                  _bebida.instrucciones,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

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
          } else if (snapshot.hasData) {
            _bebida = snapshot.data;
            return OrientationBuilder(
              builder: (context, orientation) {
                return getOrientatedUI(context, orientation);
              },
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