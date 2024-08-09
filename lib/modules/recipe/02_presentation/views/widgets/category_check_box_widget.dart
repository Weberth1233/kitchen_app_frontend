import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

import '../../../../00_core_module/bloc/generic_bloc_event.dart';
import '../../../../00_core_module/bloc/generic_bloc_state.dart';
import '../../../../00_core_module/designer_system/states_widgets/error_state_widget.dart';
import '../../../../00_core_module/designer_system/states_widgets/loading_state_widget.dart';
import '../../../01_domain/entities/category_entity.dart';
import '../../bloc/category_bloc.dart';
import '../../bloc/recipe_bloc.dart';

class CheckBoxModel {
  CategoryEntity categoryEntity;
  bool checked;

  CheckBoxModel({required this.categoryEntity, this.checked = false});
}

class CategoryCheckBoxWidget extends StatefulWidget {
  final RecipeBloc blocRecipe;
  const CategoryCheckBoxWidget({
    super.key,
    required this.blocRecipe,
  });

  @override
  State<CategoryCheckBoxWidget> createState() => _CategoryCheckBoxWidgetState();
}

class _CategoryCheckBoxWidgetState extends State<CategoryCheckBoxWidget> {
  late final CategoryBloc _blocCategory;
  //meu objeto observável RxCheckBoxModel - todos os itens dessa lista vão ser observados e podem ser atualizados caso necessário seu valor
  late final List<Rx<CheckBoxModel>> _checkBoxModels;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _blocCategory = Modular.get<CategoryBloc>();
    _blocCategory.add(LoadGenericBlocEvent<CategoryEvent>());
    _checkBoxModels = [];
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
          //Limpando e adicionando itens de categoria que vem do meu state para meu objeto observavel RxCheckBoxModel
          _checkBoxModels.clear();
          _checkBoxModels.addAll(
            state.entityList.map(
              (categoryEntity) =>
                  CheckBoxModel(categoryEntity: categoryEntity).obs,
            ),
          );
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
                    return Obx(() {
                      return CheckboxListTile(
                        value: _checkBoxModels[index].value.checked,
                        onChanged: (value) {
                          //Atualizando o o check da minha category atráves do checkbox
                          //Acesso o objeto Category e atualizo o checked para o valor do value selecionado pelo usuário
                          _checkBoxModels[index].update((category) {
                            category!.checked = value!;
                            // print(checkBox!.checked);
                          });

                          widget.blocRecipe.add(
                            RecipeByCategoryEvent<RecipeEvent>(
                              idCategory: _checkBoxModels[index]
                                  .value
                                  .categoryEntity
                                  .id,
                            ),
                          );
                        },
                        title: Text(
                          _checkBoxModels[index].value.categoryEntity.name,
                          style: theme.textTheme.bodySmall,
                        ),
                      );
                    });
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

class RowCheckBox extends StatelessWidget {
  final void Function(bool?)? onChanged;

  final CheckBoxModel checkBoxModel;

  const RowCheckBox({
    super.key,
    this.onChanged,
    required this.checkBoxModel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // final controllerCheckBox = Get.find<CheckboxController>();

    return CheckboxListTile(
      value: checkBoxModel.checked,
      onChanged: onChanged,
      title: Text(
        checkBoxModel.categoryEntity.name,
        style: theme.textTheme.bodySmall,
      ),
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Expanded(
    //       child: Text(
    //         checkBoxModel.categoryEntity.name,
    //         style: theme.textTheme.bodySmall,
    //       ),
    //     ),
    //     Checkbox(
    //       onChanged: onChanged,
    //       activeColor: Colors.green,
    //       checkColor: Colors.green,
    //       value: checkBoxModel.checked,
    //     ),
    //   ],
    // ).paddingOnly(bottom: 12);
  }
}
