import '../../../../../../app/extension/string_extension.dart';
import '../validator/validator.dart';

class PhoneNumberValidator extends Validator {
  @override
  String? validate(String value) {
    if (!value.isValidPhoneNumber()) {
      return 'Phone number must be valid';
    }

    return null;
  }
}
