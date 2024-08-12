import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kitchen_app/modules/00_core_module/designer_system/states_widgets/loading_state_widget.dart';
import 'package:kitchen_app/modules/00_core_module/designer_system/states_widgets/no_data_widget.dart';
import 'package:kitchen_app/modules/recipe/02_presentation/bloc/recipe_bloc/recipe_bloc_random_recipe.dart';

import '../../../../../base_url.dart';
import '../../../../00_core_module/bloc/generic_bloc_state.dart';
import '../../../01_domain/entities/recipe_entity.dart';

import '../../bloc/recipe_event.dart';
import '../../bloc/recipe_state.dart';

class SessionRandomRecipe extends StatefulWidget {
  const SessionRandomRecipe({
    super.key,
  });

  @override
  State<SessionRandomRecipe> createState() => _SessionRandomRecipeState();
}

class _SessionRandomRecipeState extends State<SessionRandomRecipe> {
  late final RecipeBlocRandomRecipe _blocRandomRecipe;

  @override
  void initState() {
    _blocRandomRecipe = Modular.get<RecipeBlocRandomRecipe>();
    _blocRandomRecipe.add(
      RecipeRandomEvent<RecipeEvent>(),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<RecipeBlocRandomRecipe, GenericBlocState<RecipeState>>(
      bloc: _blocRandomRecipe,
      builder: (context, state) {
        if (state is GenericBlocLoadingState<RecipeState>) {
          return const LoadingStateWidget();
        } else if (state
            is GenericBlocLoadedEntityState<RecipeState, RecipeEntity>) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        state.entity.name,
                        style: theme.textTheme.headlineSmall!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Ver mais...',
                          style: theme.textTheme.bodySmall,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  // 'Pratos do dia para aprender a fazer de forma fácil e pratica- clique em ver mais para outros opções',
                  'Prato aleatorio escolhido para aprender a fazer ',
                  style: theme.textTheme.bodySmall!
                      .copyWith(color: theme.colorScheme.outline),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
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
                            image: NetworkImage(
                              '${BaseUrlApi.baseUrlMedia}${state.entity.imageUrl}',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Modo de preparo:',
                            style: theme.textTheme.bodyMedium!.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(state.entity.steps.length,
                                (index) {
                              return ListTile(
                                leading: Text(
                                  state.entity.steps[index].numberStep
                                      .toString(),
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                      color: theme.colorScheme.outlineVariant),
                                ),
                                title: Text(
                                  state.entity.steps[index].description,
                                  textAlign: TextAlign.justify,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        } else if (state is GenericBlocNoDataState<RecipeEntity>) {
          return const NoDataWidget();
        }
        return const SizedBox();
      },
    );
  }
}
