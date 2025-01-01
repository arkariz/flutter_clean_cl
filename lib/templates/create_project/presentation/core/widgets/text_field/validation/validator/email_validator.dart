import '../validator/validator.dart';
import '../../../../../../app/extension/string_extension.dart';

class EmailValidator extends Validator {
  
  @override
  String? validate(String value) {
    if (!value.isValidEmail()) {
      return 'This field must be a valid email';
    }

    return null;
  }
}