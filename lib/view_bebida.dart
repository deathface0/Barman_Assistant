import 'package:flutter/material.dart';
import 'bebida.dart';
import 'bar.dart';

class ViewBebida extends StatefulWidget {
  final String nombre;
  final List<String> languages;
  final String initialLanguage;
  final ValueChanged<String?> onLanguageChanged;

  const ViewBebida({
    super.key,
    required this.nombre,
    required this.languages,
    required this.initialLanguage,
    required this.onLanguageChanged,
  });

  @override
  _ViewBebidaState createState() => _ViewBebidaState();
}

class _ViewBebidaState extends State<ViewBebida> {
  Bebida? _bebida;
  String _language = 'ES';

  @override
  void initState() {
    super.initState();
    _language = widget.initialLanguage;
  }

  Future<void> _loadBebida() async {
    _bebida = await BarManager.instance.getBebida(widget.nombre);
  }

  Column _getOrientatedUI(BuildContext context, Orientation orientation) {
    if (orientation == Orientation.landscape) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                child: Image.network(
                  _bebida!.urlImagen,
                  width: 300,
                  height: MediaQuery.of(context).size.height * 0.7,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _bebida!.nombre,
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
                        _language == 'ES' ? _bebida!.instruccionesES : _bebida!.instruccionesEN,
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
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 40),
          Image.network(
            _bebida!.urlImagen,
            width: 300,
            height: 300,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              _bebida!.nombre,
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
                  _language == 'ES' ? _bebida!.instruccionesES : _bebida!.instruccionesEN,
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.nombre),
        actions: <Widget>[
          DropdownButton(
            value: _language,
            icon: const Icon(Icons.keyboard_arrow_down),
            dropdownColor: Theme.of(context).colorScheme.secondary,
            isExpanded: false,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            items: widget.languages.map((String dropdownvalue) {
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
              widget.onLanguageChanged(newValue);
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<Bebida>(
          future: BarManager.instance.getBebida(widget.nombre),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                _bebida = snapshot.data;
                return OrientationBuilder(
                  builder: (context, orientation) {
                    return _getOrientatedUI(context, orientation);
                  },
                );
              } else {
                return const Text('No data available');
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}