class Bebida {
  String id;
  String nombre;
  String urlImagen;
  String instrucciones;

  Bebida({
    required this.id,
    required this.nombre,
    required this.urlImagen,
    required this.instrucciones,
  });

  factory Bebida.desdeJson(Map<String, dynamic> json) {
    bool isIngrediente = json['idDrink'] == null ? true : false;

    return Bebida(
      id: isIngrediente ? 'Unknown' : json['idDrink'],
      nombre: isIngrediente ? json['strIngredient1']: json['strDrink'],
      urlImagen: isIngrediente ? 'https://www.thecocktaildb.com/images/ingredients/${json['strIngredient1']}-Small.png' : json['strDrinkThumb'],
      instrucciones: isIngrediente ? '' : json['strInstructions'] ?? '',
    );
  }
}