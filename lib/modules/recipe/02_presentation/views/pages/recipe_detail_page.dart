import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kitchen_app/modules/core_module/designer_system/global_scaffold_widget.dart';
import '../../../../../base_url.dart';
import '../../../../core_module/features/bloc/generic_bloc_state.dart';
import '../../../../core_module/designer_system/states_widgets/error_state_widget.dart';
import '../../../../core_module/designer_system/states_widgets/loading_state_widget.dart';
import '../../../01_domain/entities/recipe_entity.dart';
import '../../bloc/recipe_bloc/recipe_bloc_detail.dart';
import '../../bloc/recipe_event.dart';
import '../../bloc/recipe_state.dart';

class RecipeDetailPage extends StatefulWidget {
  final String idRecipe;

  const RecipeDetailPage({
    super.key,
    required this.idRecipe,
  });

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late final RecipeBlocDetail _blocDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _blocDetail = Modular.get<RecipeBlocDetail>();
    _blocDetail.add(
      RecipeById<RecipeEvent>(
        id: int.parse(widget.idRecipe),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          BlocBuilder<RecipeBlocDetail, GenericBlocState<RecipeState>>(
            bloc: _blocDetail,
            builder: (context, state) {
              if (state is GenericBlocLoadingState<RecipeState>) {
                return const LoadingStateWidget();
              } else if (state
                  is GenericBlocLoadedEntityState<RecipeState, RecipeEntity>) {
                RecipeEntity entity = state.entity;
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 150, vertical: 103),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entity.name,
                        style: theme.textTheme.displaySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Categoria kkkkkkkk: ${entity.category.name}",
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: theme.colorScheme.outlineVariant),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Criado em : ${entity.date}",
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                              image: NetworkImage(
                                  '${BaseUrlApi.baseUrlMedia}${entity.imageUrl}')),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.outlineVariant,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(9.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('SAVE',
                                      style: theme.textTheme.bodySmall!
                                          .copyWith(color: Colors.white)),
                                  const Icon(
                                    Icons.save,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.outlineVariant,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(9.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'PRINT',
                                    style: theme.textTheme.bodySmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                  const Icon(
                                    Icons.print,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Ingredientes',
                        style: theme.textTheme.bodyMedium,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            List.generate(entity.ingredients.length, (index) {
                          return Row(
                            children: [
                              const Icon(Icons.food_bank_rounded),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(entity.ingredients[index].name),
                            ],
                          );
                        }),
                      )
                    ],
                  ),
                );
              } else if (state is GenericBlocErrorState<RecipeState>) {
                ErrorStateWidget(
                  message: state.message,
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
