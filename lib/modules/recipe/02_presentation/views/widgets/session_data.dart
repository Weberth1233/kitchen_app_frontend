//session menu of the day
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../../base_url.dart';
import '../../../../00_core_module/designer_system/cards/card_widget.dart';
import '../../../01_domain/entities/recipe_entity.dart';

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
                child: Text(
                  // 'Cardapio do dia',
                  text,
                  style: theme.textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w600, shadows: [
                    // const Shadow(
                    //   offset: Offset(3.0, 3.0),
                    //   blurRadius: 3.0,
                    //   color: Color.fromRGBO(10, 10, 10, 0.2),
                    // )
                  ]),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Ver mais...',
                  style: theme.textTheme.bodySmall,
                ),
              )
            ],
          ),
          Text(
            // 'Pratos do dia para aprender a fazer de forma fácil e pratica- clique em ver mais para outros opções',
            subText,
            style: theme.textTheme.bodySmall!
                .copyWith(color: theme.colorScheme.outline),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: List.generate(list.length, (index) {
              RecipeEntity recipe = list[index];
              return Expanded(
                child: CardWidget(
                  image: NetworkImage(
                      '${BaseUrlApi.baseUrlMedia}${recipe.imageUrl}'),
                  name: recipe.name,
                  duration: recipe.timeToPrepare.toString(),
                  category: recipe.category.name,
                ).paddingOnly(right: 10),
              );
            }),
          ),
        ],
      ),
    );
  }
}
