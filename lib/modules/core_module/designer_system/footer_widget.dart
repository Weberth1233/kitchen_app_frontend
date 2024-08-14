import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 180, vertical: 71),
      width: double.infinity,
      height: 549,
      color: theme.colorScheme.secondary,
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LINKS',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.onSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Receitas',
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: theme.colorScheme.onSecondary),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Pesquisa',
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: theme.colorScheme.onSecondary),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Sobre',
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: theme.colorScheme.onSecondary),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('FOLLOW US',
                        style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.colorScheme.onSecondary,
                            fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        IconButton(
                            iconSize: 27,
                            onPressed: () {},
                            icon: Icon(
                              Icons.facebook,
                              color: theme.colorScheme.onSecondary,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          iconSize: 27,
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.linkedin,
                            color: theme.colorScheme.onSecondary,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          iconSize: 27,
                          onPressed: () {},
                          icon: Icon(
                            Icons.email,
                            color: theme.colorScheme.onSecondary,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            iconSize: 27,
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.instagram,
                              color: theme.colorScheme.onSecondary,
                            )),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(
            color: theme.colorScheme.onSecondary,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '@${DateTime.now().year.toString()} All rights reserved - Weberth Erik',
            style: theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.onSecondary,
            ),
          )
        ],
      ),
    );
  }
}
