import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;

  const ErrorStateWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          size: 70,
          color: theme.colorScheme.error,
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: theme.textTheme.displayMedium!
              .copyWith(fontWeight: FontWeight.w500)
              .copyWith(color: theme.colorScheme.error),
        ),
      ],
    );
  }
}
