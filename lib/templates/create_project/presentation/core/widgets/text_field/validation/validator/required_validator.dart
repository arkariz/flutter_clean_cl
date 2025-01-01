import '../validator/validator.dart';

class RequiredValidator extends Validator {
  
  @override
  String? validate(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
