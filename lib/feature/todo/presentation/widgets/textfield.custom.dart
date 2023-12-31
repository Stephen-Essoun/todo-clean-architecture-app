import 'package:flutter/material.dart';

Widget customTextField({
  required String labelText,
  TextEditingController? controller,
  String? initialValue,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controller,
      initialValue: initialValue,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          isDense: true,
          labelText: labelText),
    ),
  );
}
