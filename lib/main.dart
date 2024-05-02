import 'package:barman_assistant/grid_bebidas.dart';
import 'package:flutter/material.dart';
import 'bar.dart';
import 'bebida.dart';
import 'miniatura.dart';

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
  Map<String, dynamic>? _horizontal;
  Map<String, dynamic>? _vertical;

  /*void fillHorizontal(String endpoint) async {
    Map<String, dynamic>? json = await BarManager.instance.fetchData(endpoint);
    setState(() {
      _horizontal = json;
    });
  }

  void fillVertical(String endpoint) async {
    Map<String, dynamic>? json = await BarManager.instance.fetchData(endpoint);
    setState(() {
      _vertical = json;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: BarManager.instance.getBebidas(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('No se puede conectar con el servidor'),
              );
            } else if (snapshot.hasData) { // Check if data is available
              return Center(
                child: GridBebidas(bebidas: snapshot.data),
              );
            } else {
              return const Center(child: Text('No hay datos disponibles'));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
