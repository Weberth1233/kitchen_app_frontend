import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:kitchen_app/modules/00_core_modules/bloc/generic_bloc_event.dart';
import 'package:kitchen_app/modules/00_core_modules/bloc/generic_bloc_state.dart';
import '../../../00_core_modules/designer_system/cards/card_widget.dart';
import '../../../00_core_modules/designer_system/global_scaffold_widget.dart';
import '../bloc/recipe_bloc.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
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
    final theme = Theme.of(context);
    double sizeWidht = MediaQuery.of(context).size.width;

    return GlobalScaffoldWidget(
      appBarTitle: 'Comida',
      body: BlocBuilder<RecipeBloc, GenericBlocState<RecipeState>>(
        bloc: _bloc,
        builder: (context, state) {
          print("Estado = $state");
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: sizeWidht < 1350 ? 20 : 250, vertical: 50),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= 800) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(right: 50),
                          color: Colors.transparent,
                          height: 869,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Filtrar por tipo',
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const Text('Categorias tipos - '),
                              const SizedBox(
                                height: 20,
                              ),
                              const RowCheckBox(
                                text: 'Fitness',
                              ),
                              const RowCheckBox(
                                text: 'Família brasileira',
                              ),
                              const RowCheckBox(
                                text: 'Churrasco de domingo',
                              ),
                              const RowCheckBox(
                                text: 'Japonesa',
                              ),
                              const RowCheckBox(
                                text: 'Chinesa',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          color: Colors.transparent,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                runSpacing: 20,
                                children: [
                                  CardWidget(
                                    sizeWidht: constraints.maxWidth <= 1250
                                        ? 300
                                        : 404,
                                    image: const AssetImage(
                                      'assets/images/donuts.jpg',
                                    ),
                                    name: 'Donnuts(American Food)',
                                    duration: 'Duração: 30 minutos',
                                  ),
                                  CardWidget(
                                    sizeWidht: constraints.maxWidth <= 1250
                                        ? 300
                                        : 404,
                                    image: const AssetImage(
                                      'assets/images/donuts.jpg',
                                    ),
                                    name: 'Donnuts(American Food)',
                                    duration: 'Duração: 30 minutos',
                                  ),
                                  CardWidget(
                                    sizeWidht: constraints.maxWidth <= 1250
                                        ? 300
                                        : 404,
                                    image: const AssetImage(
                                      'assets/images/donuts.jpg',
                                    ),
                                    name: 'Donnuts(American Food)',
                                    duration: 'Duração: 30 minutos',
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          );
        },
      ),
    );
  }
}

class RowCheckBox extends StatelessWidget {
  final String text;
  final void Function(bool?)? onChanged;
  final bool? value;
  const RowCheckBox({
    super.key,
    required this.text,
    this.onChanged,
    this.value = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium,
          ),
        ),
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.green,
        ),
      ],
    ).paddingOnly(bottom: 12);
  }
}
