import 'package:flutter/material.dart';
import 'bar.dart';
import 'view_bebida.dart';
import 'bebida.dart';
import 'ui_orientator.dart';

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

  final List<String> _languages = <String>['ES', 'EN'];
  String _language = 'ES';

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
        actions: <Widget>[
          DropdownButton(
            // Initial Value
            value: _language,
            icon: const Icon(Icons.keyboard_arrow_down),
            dropdownColor: Theme.of(context).colorScheme.secondary,
            isExpanded: false,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            items: _languages.map((String dropdownvalue) {
              return DropdownMenuItem(
                value: dropdownvalue,
                child: Text(
                  dropdownvalue,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
            hint: const Text('Idioma'),
            onChanged: (String? newValue) {
              setState(() {
                _language = newValue!;
              });
            },
          ),
        ],
      ),
      body: UI_Orientator(
        ingredients: ingredients,
        selectedIngredient: _selectedIngredient,
        filters: filters,
        filter: _filter,
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
                builder: (context) => ViewBebida(
                  nombre: nombre,
                  languages: _languages,
                  initialLanguage: _language,
                  onLanguageChanged: (String? lang)
                  {
                    setState(() {
                      _language = lang!;
                    });
                  },
                ),
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
