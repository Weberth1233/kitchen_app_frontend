//session menu of the day
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../base_url.dart';
import 'cards/card_widget.dart';
import '../../recipe/01_domain/entities/recipe_entity.dart';

class SessionData extends StatelessWidget {
  final List<RecipeEntity> list;
  final String text;
  final String subText;
  const SessionData(
      {super.key,
      required this.list,
      required this.text,
      required this.subText});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(text,
                    style: theme.textTheme.headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold)),
              ),
              TextButton(
                onPressed: () {
                  // Modular.to.navigate('/recipe_detail');
                },
                child: Text(
                  'Ver mais...',
                  style: theme.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.secondary),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            // 'Pratos do dia para aprender a fazer de forma fácil e pratica- clique em ver mais para outros opções',
            subText,
            style: theme.textTheme.bodySmall!
                .copyWith(color: theme.colorScheme.outline),
          ),
          const SizedBox(
            height: 25,
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            children: List.generate(list.length, (index) {
              RecipeEntity recipe = list[index];
              return SizedBox(
                width: 260,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Modular.to.pushNamed('/recipe_detail/${recipe.id}');
                    },
                    child: CardWidget(
                      image: NetworkImage(
                          '${BaseUrlApi.baseUrlMedia}${recipe.imageUrl}'),
                      name: recipe.name,
                      duration: recipe.timeToPrepare.toString(),
                      category: recipe.category.name,
                    ).paddingOnly(right: 10),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
