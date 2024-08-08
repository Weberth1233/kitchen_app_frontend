import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kitchen_app/modules/recipe/01_domain/entities/category_entity.dart';
import 'package:kitchen_app/modules/recipe/02_presentation/bloc/category_bloc.dart';

import '../../../../00_core_module/bloc/generic_bloc_event.dart';
import '../../../../00_core_module/bloc/generic_bloc_state.dart';
import '../../../../00_core_module/designer_system/states_widgets/error_state_widget.dart';
import '../../../../00_core_module/designer_system/states_widgets/loading_state_widget.dart';
import '../recipe_page.dart';

class CategoryCheckBoxWidget extends StatefulWidget {
  const CategoryCheckBoxWidget({
    super.key,
  });

  @override
  State<CategoryCheckBoxWidget> createState() => _CategoryCheckBoxWidgetState();
}

class _CategoryCheckBoxWidgetState extends State<CategoryCheckBoxWidget> {
  late final CategoryBloc _blocCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _blocCategory = Modular.get<CategoryBloc>();
    _blocCategory.add(LoadGenericBlocEvent<CategoryEvent>());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CategoryBloc, GenericBlocState<CategoryState>>(
      bloc: _blocCategory,
      builder: (context, state) {
        if (state is GenericBlocLoadingState<CategoryState>) {
          return const LoadingStateWidget();
        } else if (state
            is GenericBlocLoadedState<CategoryState, CategoryEntity>) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filtrar por tipo',
                style: theme.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Text('Categorias tipos'),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: List.generate(
                  state.entityList.length,
                  (index) {
                    return RowCheckBox(
                      text: state.entityList[index].name,
                    );
                  },
                ),
              )
            ],
          );
        } else if (state is GenericBlocErrorState<CategoryState>) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 120),
            child: ErrorStateWidget(
              message: state.message,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
