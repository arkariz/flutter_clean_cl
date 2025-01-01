import '../../../../../../app/extension/string_extension.dart';
import '../validator/validator.dart';

class SpecialCharacterValidator extends Validator {

  @override
  String? validate(String value) {
    if (!value.isNoSpecialCharacter()) {
      return 'This field must be without special character';
    }

    return null;
  }
}
