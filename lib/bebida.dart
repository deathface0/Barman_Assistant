class Bebida {
  String id;
  String nombre;
  String urlImagen;
  String instruccionesEN;
  String instruccionesES;

  Bebida({
    required this.id,
    required this.nombre,
    required this.urlImagen,
    required this.instruccionesEN,
    required this.instruccionesES,
  });

  factory Bebida.desdeJson(Map<String, dynamic> json) {
    bool isIngrediente = json['idDrink'] == null ? true : false;

    return Bebida(
      id: isIngrediente ? 'Unknown' : json['idDrink'],
      nombre: isIngrediente ? json['strIngredient1']: json['strDrink'],
      urlImagen: isIngrediente ? 'https://www.thecocktaildb.com/images/ingredients/${json['strIngredient1']}-Small.png' : json['strDrinkThumb'],
      instruccionesEN: isIngrediente ? '' : json['strInstructions'] ?? 'No english instructions',
      instruccionesES: isIngrediente ? '' : json['strInstructionsES'] ?? 'No existen instrucciones en español',
    );
  }
}