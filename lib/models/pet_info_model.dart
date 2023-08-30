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

  factory PetInfo.fromJson(Map<String, dynamic> json) {
    return PetInfo(
      name: json['name'],
      species: json['species'],
      birthday: json['birthday'],
      deathday: json['deathday'],
    );
  }
}
