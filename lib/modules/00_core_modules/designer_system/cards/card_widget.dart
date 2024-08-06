import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final double sizeWidht;
  final ImageProvider<Object> image;
  final String name;
  final String duration;
  const CardWidget({
    super.key,
    required this.sizeWidht,
    required this.image,
    required this.name,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 485,
      width: sizeWidht,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 90,
                    offset: Offset(5, 0),
                    spreadRadius: 0.1,
                    blurStyle: BlurStyle.normal,
                  )
                ],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: image,
                ),
              ),
            ),
          ),
          Text(
            name,
            style: theme.textTheme.headlineMedium,
          ),
          Text(
            duration,
            style: theme.textTheme.bodySmall,
          )
        ],
      ),
    );
  }
}
