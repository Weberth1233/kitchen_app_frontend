import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintTextFormField;
  final bool isBottomPadding;
  const TextInputWidget({
    super.key,
    required this.controller,
    required this.hintTextFormField,
    this.isBottomPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(bottom: isBottomPadding ? 22 : 0),
      child: TextFormField(
        keyboardType: TextInputType.name,
        style: const TextStyle(height: 1.0),
        decoration: InputDecoration(
          hintText: hintTextFormField,
        ),
        controller: controller,
      ),
    );
  }
}
