class Pet {
  final String name;
  final String species;
  final String birthday;
  final String deathday;
  final String? image;

  Pet({
    required this.name,
    required this.species,
    required this.birthday,
    required this.deathday,
    this.image,
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
  String? image;

  PetInfo({
    required this.name,
    required this.species,
    required this.birthday,
    required this.deathday,
    this.image,
  });

  factory PetInfo.fromJson(Map<String, dynamic> json) {
    return PetInfo(
      name: json['name'],
      species: json['species'],
      birthday: json['birthday'],
      deathday: json['deathday'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'species': species,
      'birthday': birthday,
      'deathday': deathday,
      'image': image,
    };
  }
}
