import '../validator/validator.dart';

class CustomValidator extends Validator {
  final Function(String val)? function;

  CustomValidator({
    this.function,
  });

  @override
  String? validate(String value) {
    return function!(value);
  }
}
