class PetInfoInput {
  final String registered;

  PetInfoInput({
    required this.registered,
  });

  factory PetInfoInput.fromJson(Map<String, dynamic> json) {
    return PetInfoInput(
      registered: json['registered'],
    );
  }
}
