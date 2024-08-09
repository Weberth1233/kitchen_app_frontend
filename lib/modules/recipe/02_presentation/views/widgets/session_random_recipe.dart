import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_app/modules/00_core_module/designer_system/states_widgets/loading_state_widget.dart';
import 'package:kitchen_app/modules/00_core_module/designer_system/states_widgets/no_data_widget.dart';

import '../../../../../base_url.dart';
import '../../../../00_core_module/bloc/generic_bloc_state.dart';
import '../../../01_domain/entities/recipe_entity.dart';
import '../../bloc/recipe_bloc.dart';

class SessionRandomRecipe extends StatefulWidget {
  final RecipeBloc bloc;
  const SessionRandomRecipe({
    super.key,
    required this.bloc,
  });

  @override
  State<SessionRandomRecipe> createState() => _SessionRandomRecipeState();
}

class _SessionRandomRecipeState extends State<SessionRandomRecipe> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.bloc.add(
      RecipeRandomEvent<RecipeEvent>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<RecipeBloc, GenericBlocState<RecipeState>>(
      bloc: widget.bloc,
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
                Text(state.entity.name, style: theme.textTheme.headlineSmall!),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  // 'Pratos do dia para aprender a fazer de forma fácil e pratica- clique em ver mais para outros opções',
                  'Prato aleatorio escolhido para aprender a fazer ',
                  style: theme.textTheme.bodySmall!
                      .copyWith(color: theme.colorScheme.outline),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 440,
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
                            image: NetworkImage(
                              '${BaseUrlApi.baseUrlMedia}${state.entity.imageUrl}',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:
                            List.generate(state.entity.steps.length, (index) {
                          return Text(
                            state.entity.steps[index].description,
                          );
                        }),
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
