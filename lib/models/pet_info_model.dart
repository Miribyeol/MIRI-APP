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
class PetInfo {
  final String name;
  final String species;
  final String birthday;
  final String deathday;

  PetInfo({
    required this.name,
    required this.species,
    required this.birthday,
    required this.deathday,
  });

  // Add a factory method to create an instance from JSON
  factory PetInfo.fromJson(Map<String, dynamic> json) {
    return PetInfo(
      name: json['name'],
      species: json['species'],
      birthday: json['birthday'],
      deathday: json['deathday'],
    );
  }

  // Add a method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'species': species,
      'birthday': birthday,
      'deathday': deathday,
    };
  }
}


