class ValidationData {
  String? message;
  String? value;
  String? formatDate;
  int? maxCharacter;
  int? minCharacter;
  int? minAge;
  int? ageValue;
  bool? isEnabled;
  Function(String)? functionValidation;

  ValidationData({
    this.message = '',
    this.isEnabled = true,
  });

  // todo : will be adjustment to for maxCharacter only
  ValidationData.character({
    required this.message,
    this.maxCharacter = 0,
    this.value = '',
    this.minCharacter = 0,
    this.isEnabled = true,
  });

  ValidationData.minCharacter({
    required this.message,
    this.value = '',
    this.minCharacter = 0,
    this.isEnabled = true,
  });

  ValidationData.functionValidation({
    required this.functionValidation,
    this.isEnabled = true,
  });

  ValidationData.age({
    required this.message,
    required this.ageValue,
    required this.minAge,
    this.isEnabled = true,
  });
}
