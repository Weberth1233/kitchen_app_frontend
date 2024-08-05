import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String textButton;
  final void Function()? onPressed;
  const ButtonWidget({
    super.key,
    required this.textButton,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: const Color(0xFFDB3541)),
      onPressed: onPressed,
      child: Text(
        textButton,
        style: theme.textTheme.bodyMedium!
            .copyWith(color: theme.colorScheme.onSecondary),
      ),
    );
  }
}
