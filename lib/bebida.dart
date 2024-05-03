class Bebida {
  String id;
  String nombre;
  String urlImagen;

  Bebida({
    required this.id,
    required this.nombre,
    required this.urlImagen,
  });

  factory Bebida.desdeJson(Map<String, dynamic> json) {
    return Bebida(
      id: json['idDrink'] ?? 'Unknown',
      nombre: json['idDrink'] == null ? json['strIngredient1'] ?? 'Unknown' : json['strDrink'] ?? 'Unknown',
      urlImagen: json['idDrink'] == null ? 'https://www.thecocktaildb.com/images/ingredients/${json['strIngredient1']}-Small.png' : json['strDrinkThumb'] ?? 'Unknown',
    );
  }
}