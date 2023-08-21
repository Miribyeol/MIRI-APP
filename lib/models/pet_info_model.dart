class Pet {
  final String name;
  final String species;
  final String birthday;
  final String deathday;
  final String image;

  Pet({
    required this.name,
    required this.species,
    required this.birthday,
    required this.deathday,
    required this.image,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      name: json['name'],
      species: json['species'],
      birthday: json['birthday'],
      deathday: json['deathday'],
      image: json['image'],
    );
  }
}
