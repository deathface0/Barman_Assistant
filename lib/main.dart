import 'package:flutter/material.dart';
import 'bar.dart';
import 'view_bebida.dart';
import 'bebida.dart';
import 'ui_orientator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barman Assistant',
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
  String _selectedIngredient = 'Rum';

  List<String> filters = <String>[];
  String _filter = 'Ingredient';

  String _selectedDrink = 'None';

  @override
  void initState() {
    super.initState();
    BarManager.instance.getIngredientes().then((ingredientes) {
      setState(() {
        ingredients = ingredientes;
      });
    });

    BarManager.instance.getCategorias().then((categorias) {
      setState(() {
        categorias.insert(0, 'Ingredient');
        filters = categorias;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(widget.title),
        ),
        body: UI_Orientator(
          ingredients: ingredients,
          filters: filters,
          filter: _filter,
          selectedIngredient: _selectedIngredient,
          onIngredienteClicked: (nombre) {
            setState(() {
              _selectedIngredient = nombre!;
              _filter = 'Ingredient';
            });
          },
          onBebidaClicked: (nombre) {
            setState(() {
              _selectedDrink = nombre!;

              // Navigate to the second page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewBebida(nombre: nombre),
                ),
              );
            });
          },
          onFiltroClicked: (String? newValue) {
            setState(() {
              if (newValue != 'Ingredient') {
                _selectedIngredient = 'None';
              }
              _filter = newValue! != 'Ingredient' ? newValue! : _filter;
            });
          },
        ),
    );
  }
}
