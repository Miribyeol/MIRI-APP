class PetInput {
  final String name;
  final String species;
  final String birthday;
  final String deathday;
  final String? image;

  PetInput({
    required this.name,
    required this.species,
    required this.birthday,
    required this.deathday,
    this.image,
  });

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
