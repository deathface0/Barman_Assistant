import 'grid_bebidas.dart';
import 'package:flutter/material.dart';
import 'bar.dart';
import 'view_bebida.dart';
import 'bebida.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Barman Assistant'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Bebida> ingredients = <Bebida>[];
  List<String> filters = <String>[];

  String _selectedIngredient = 'Rum';
  String _selectedDrink = 'None';
  String filter = 'None';

  @override
  void initState() {
    super.initState();

    BarManager.instance.getCategorias().then((categorias) {
      setState(() {
        filters = categorias;
      });
    });

    BarManager.instance.getIngredientes().then((ingredientes) {
      setState(() {
        ingredients = ingredientes;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ing = Center(
      child: GridBebidas(
        bebidas: ingredients,
        onBebidaClicked: (nombre) {
          setState(() {
            _selectedIngredient = nombre;
          });
        },
      ),
    );

    final future2 = FutureBuilder(
      future: BarManager.instance.getBebidas(_selectedIngredient),
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
                onBebidaClicked: (nombre) {
                  setState(() {
                    _selectedDrink = nombre;

                    // Navigate to the second page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewBebida(nombre: nombre),
                      ),
                    );
                  });
                },
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1, // Adjust the flex value as needed
            child: ing,
          ),
          Expanded(
            flex: 0,
            child: const Text(''),
          ),
          Expanded(
            flex: 3, // Adjust the flex value as needed
            child: future2,
          ),
        ],
      ),
    );
  }
}
