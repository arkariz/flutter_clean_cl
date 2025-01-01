import 'package:flutter/material.dart';
import '../text_field/validation/type_def.dart';
import '../text_field/validation/validator/validator.dart';
import '../text_field/validation/validation_data.dart';
import '../text_field/validation/validation_message.dart';
import '../text_field/validation/validator/age_validator.dart';
import '../text_field/validation/validator/custom_validator.dart';
import '../text_field/validation/validator/email_validator.dart';
import '../text_field/validation/validator/max_character_validator.dart';
import '../text_field/validation/validator/min_character_validator.dart';
import '../text_field/validation/validator/phone_number_validator.dart';
import '../text_field/validation/validator/required_validator.dart';
import '../text_field/validation/validator/special_character_validator.dart';
import '../text_field/widget/form_error_message.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.validation,
  });

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final ValidationsMap? validation;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(widget.label),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            errorStyle: const TextStyle(height: 0.01, color: Colors.transparent, fontSize: 0,)
          ),
          validator: (value) => widget.validation != null ? _createValidation(widget.validation) : null,
        ),
        FormErrorMessage(errorText: errorMessage),
      ],
    );
  }

  String? _createValidation(Map<String, ValidationData>? validationMessages) {
    assert(widget.controller != null, 'You must provide a TextEditingController');
    if (validationMessages == null) {
      return null;
    }

    final String value = widget.controller!.text;
    for (final String key in validationMessages.keys) {
      if (!validationMessages[key]!.isEnabled!) {
        continue;
      }

      final Validator? validator = _createValidator(key, validationMessages);
      if (validator != null) {
        final String? error = validator.validate(value);

        if (key == ValidationMessage.custom) {
          final String? result = validationMessages[key]!.functionValidation!(value);
          _updateErrorState(result);
          return result;
        }

        if (error != null) {
          final result = validationMessages[key]!.message.toString().isEmpty 
            ? error 
            : validationMessages[key]!.message.toString();
                
          _updateErrorState(result);
          return errorMessage;
        }

        _updateErrorState(null);
      }
    }
    return null;
  }

  Validator? _createValidator(String key, Map<String, ValidationData>? validation) {
    switch (key) {
        case ValidationMessage.required:
          return RequiredValidator();
        case ValidationMessage.email:
          return EmailValidator();
        case ValidationMessage.phoneNumber:
          return PhoneNumberValidator();
        case ValidationMessage.withoutSpesialCharacter:
          return SpecialCharacterValidator();
        case ValidationMessage.custom:
          return CustomValidator(function: (value) => validation![key]!.functionValidation!(widget.controller!.text));
        case ValidationMessage.minAge:
          if (key == ValidationMessage.minAge) {
            assert(validation![key]!.minAge != null, 'You must provide a minAge parameter');
          }
          return MinAgeValidator(
            minAge: validation![key]!.minAge!,
            age: validation[key]!.ageValue!,
          );
        case ValidationMessage.maxCharacter:
          if (key == ValidationMessage.maxCharacter) {
            assert(validation![key]!.maxCharacter != null, 'You must provide a maxCharacter parameter');
          }
          return MaxCharacterValidator(
              maxCharacter: validation![key]!.maxCharacter!,
          );
        case ValidationMessage.minCharacter:
          if (key == ValidationMessage.minCharacter) {
            assert(validation![key]!.minCharacter != null, 'You must provide a minCharacter parameter');
          }
          return MinCharacterValidator(minCharacter: validation![key]!.minCharacter!);
        default:
          return null;
    }
  }

  void _updateErrorState(String? error) {
    setState(() {
      if (error != null) {
        errorMessage = error;
      } else {
        errorMessage = "";
      }
    });
  }
}