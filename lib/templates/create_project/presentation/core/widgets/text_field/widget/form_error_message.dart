import 'package:flutter/material.dart';

class FormErrorMessage extends StatelessWidget {
  final String errorText;
  final bool isShowIcon;

  const FormErrorMessage({
    super.key,
    required this.errorText,
    this.isShowIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: errorText.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          children: <Widget>[
            if(isShowIcon) const Icon(Icons.warning, size: 16, color: Color(0xFFD81600)),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                errorText,
                style: const TextStyle(color: Color(0xFFD81600)),
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
