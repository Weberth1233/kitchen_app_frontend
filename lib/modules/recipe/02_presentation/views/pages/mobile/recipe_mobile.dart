import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core_module/designer_system/states_widgets/error_state_widget.dart';
import '../../../../../core_module/designer_system/states_widgets/loading_state_widget.dart';
import '../../../../../core_module/features/bloc/generic_bloc_event.dart';
import '../../../../../core_module/features/bloc/generic_bloc_state.dart';
import '../../../../01_domain/entities/recipe_entity.dart';
import '../../../bloc/recipe_bloc/recipe_bloc_general.dart';
import '../../../bloc/recipe_event.dart';
import '../../../bloc/recipe_state.dart';

class RecipePageMobile extends StatefulWidget {
  const RecipePageMobile({super.key});

  @override
  State<RecipePageMobile> createState() => _RecipePageMobileState();
}

class _RecipePageMobileState extends State<RecipePageMobile> {
  late final RecipeBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = Modular.get<RecipeBloc>();
    _bloc.add(LoadGenericBlocEvent<RecipeEvent>());
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // double sizeWidht = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBarTitle: 'Comida',
      body: BlocBuilder<RecipeBloc, GenericBlocState<RecipeState>>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is GenericBlocLoadingState<RecipeState>) {
            return const LoadingStateWidget();
          } else if (state
              is GenericBlocLoadedState<RecipeState, RecipeEntity>) {
            return const Text('MOBILE');
          } else if (state is GenericBlocErrorState<RecipeState>) {
            ErrorStateWidget(
              message: state.message,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
