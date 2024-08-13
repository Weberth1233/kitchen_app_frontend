import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core_module/features/bloc/generic_bloc_state.dart';
import '../../../../core_module/designer_system/states_widgets/error_state_widget.dart';
import '../../../../core_module/designer_system/states_widgets/loading_state_widget.dart';
import '../../../../core_module/designer_system/states_widgets/no_data_widget.dart';
import '../../../../core_module/utils/responsive.dart';
import '../../../01_domain/entities/recipe_entity.dart';
import '../../bloc/recipe_bloc/recipe_bloc_general.dart';
import '../../../../core_module/designer_system/session_data.dart';
import '../../bloc/recipe_state.dart';

class SessionMenuOfTheDayRecipe extends StatefulWidget {
  final RecipeBloc blocRecipe;
  final String text;
  final String subText;
  const SessionMenuOfTheDayRecipe(
      {super.key,
      required this.blocRecipe,
      required this.text,
      required this.subText});

  @override
  State<SessionMenuOfTheDayRecipe> createState() =>
      _SessionMenuOfTheDayRecipeState();
}

class _SessionMenuOfTheDayRecipeState extends State<SessionMenuOfTheDayRecipe> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, GenericBlocState<RecipeState>>(
      bloc: widget.blocRecipe,
      builder: (context, state) {
        if (state is GenericBlocLoadingState<RecipeState>) {
          return const LoadingStateWidget();
        } else if (state is GenericBlocLoadedState<RecipeState, RecipeEntity>) {
          return Responsive.maxWidthScreen(context) > 1000
              ? SessionData(
                  text: widget.text,
                  subText: widget.subText,
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
