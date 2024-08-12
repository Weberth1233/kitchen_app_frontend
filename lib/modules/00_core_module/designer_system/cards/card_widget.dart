import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final ImageProvider<Object> image;
  final String name;
  final String duration;
  final String category;

  const CardWidget({
    super.key,
    required this.image,
    required this.name,
    required this.duration,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 485,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 20,
                    offset: Offset(2, 4),
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
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 120,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  'Total de tempo: $duration minutos',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  'Categoria: $category',
                  style: theme.textTheme.bodySmall!
                      .copyWith(color: theme.colorScheme.outlineVariant),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
