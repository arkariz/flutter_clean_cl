import '../validator/validator.dart';

class MinAgeValidator extends Validator {
  final int minAge;
  final int? age;

  MinAgeValidator({required this.minAge,this.age});

  @override
  String? validate(String value) {    
    if (age! < minAge) {
      return 'Age must be greater than $minAge';
    }

    return null;
  }
}
