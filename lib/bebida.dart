class Bebida {
  String id;
  String nombre;
  String urlImagen;
  //String alcohol;
  //List<String> ingredientes;

  Bebida({
    required this.id,
    required this.nombre,
    required this.urlImagen,
    //required this.alcohol,
    //required this.ingredientes,
  });

  factory Bebida.desdeJson(Map<String, dynamic> json) {
    return Bebida(
      id: json['idDrink'],
      nombre: json['strDrink'],
      urlImagen: json['strDrinkThumb'],
      //alcohol: json['strAlcoholic'],
      //ingredientes: <String>[],
    );
  }
}