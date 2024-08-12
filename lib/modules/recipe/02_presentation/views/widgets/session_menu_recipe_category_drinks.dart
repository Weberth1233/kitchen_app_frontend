import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../00_core_module/bloc/generic_bloc_state.dart';
import '../../../../00_core_module/designer_system/session_data.dart';
import '../../../../00_core_module/designer_system/states_widgets/error_state_widget.dart';
import '../../../../00_core_module/designer_system/states_widgets/loading_state_widget.dart';
import '../../../../00_core_module/designer_system/states_widgets/no_data_widget.dart';
import '../../../../00_core_module/utils/responsive.dart';
import '../../../01_domain/entities/recipe_entity.dart';
import '../../bloc/recipe_bloc/recipe_bloc_general.dart';
import '../../bloc/recipe_bloc/recipe_bloc_recipes_by_category.dart';
import '../../bloc/recipe_event.dart';
import '../../bloc/recipe_state.dart';

class SessionMenuRecipeDrinks extends StatefulWidget {
  const SessionMenuRecipeDrinks({super.key});

  @override
  State<SessionMenuRecipeDrinks> createState() =>
      _SessionMenuRecipeDrinksState();
}

class _SessionMenuRecipeDrinksState extends State<SessionMenuRecipeDrinks> {
  late final RecipeBlocRecipesByCategory _blocRecipeDrinks;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _blocRecipeDrinks = Modular.get<RecipeBlocRecipesByCategory>();
    _blocRecipeDrinks.add(RecipeByCategoryEvent<RecipeEvent>(idCategory: 12));
    // _blocCategory.add(LoadGenericBlocEvent<CategoryEvent>());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBlocRecipesByCategory,
        GenericBlocState<RecipeState>>(
      bloc: _blocRecipeDrinks,
      builder: (context, state) {
        if (state is GenericBlocLoadingState<RecipeState>) {
          return const LoadingStateWidget();
        } else if (state is GenericBlocLoadedState<RecipeState, RecipeEntity>) {
          return Responsive.maxWidthScreen(context) > 1000
              ? SessionData(
                  text: 'Refresque-se com Sabor',
                  subText:
                      'Descubra como preparar bebidas deliciosas e saudáveis em poucos minutos. Explore nossas receitas refrescantes!',
                  list: state.entityList,
                )
              : const SizedBox();
        } else if (state is GenericBlocErrorState<RecipeState>) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 120),
            child: ErrorStateWidget(
              message: state.message,
            ),
          );
        } else if (state is GenericBlocNoDataState<RecipeState>) {
          return const NoDataWidget();
        }
        return const SizedBox();
      },
    );
  }
}
