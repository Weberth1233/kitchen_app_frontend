import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../core_module/features/bloc/generic_bloc_state.dart';
import '../../../../core_module/designer_system/session_data.dart';
import '../../../../core_module/designer_system/states_widgets/error_state_widget.dart';
import '../../../../core_module/designer_system/states_widgets/loading_state_widget.dart';
import '../../../../core_module/designer_system/states_widgets/no_data_widget.dart';
import '../../../../core_module/utils/responsive.dart';
import '../../../01_domain/entities/recipe_entity.dart';
import '../../bloc/recipe_bloc/recipe_bloc_recipes_by_category.dart';
import '../../bloc/recipe_event.dart';
import '../../bloc/recipe_state.dart';

class SessionMenuRecipeCandys extends StatefulWidget {
  const SessionMenuRecipeCandys({super.key});

  @override
  State<SessionMenuRecipeCandys> createState() =>
      _SessionMenuRecipeCandysState();
}

class _SessionMenuRecipeCandysState extends State<SessionMenuRecipeCandys> {
  late final RecipeBlocRecipesByCategory _blocRecipeDrinks;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _blocRecipeDrinks = Modular.get<RecipeBlocRecipesByCategory>();
    _blocRecipeDrinks.add(RecipeByCategoryEvent<RecipeEvent>(idCategory: 9));
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
                  text: 'Bolos, tortas e doces',
                  subText:
                      'Descubra como preparar doces deliciosas em poucos minutos. Explore nossas receitas!',
                  list: state.entityList,
                  scrool: true,
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
