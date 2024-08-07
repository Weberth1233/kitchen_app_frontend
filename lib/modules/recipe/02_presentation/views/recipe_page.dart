import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import '../../../00_core_module/bloc/generic_bloc_event.dart';
import '../../../00_core_module/bloc/generic_bloc_state.dart';
import '../../../00_core_module/designer_system/global_scaffold_widget.dart';
import '../../../00_core_module/designer_system/states_widgets/error_state_widget.dart';
import '../../../00_core_module/designer_system/states_widgets/loading_state_widget.dart';
import '../../../00_core_module/utils/responsive.dart';
import '../../01_domain/entities/recipe_entity.dart';
import '../bloc/category_bloc.dart';
import '../bloc/recipe_bloc.dart';
import 'widgets/category_check_box_widget.dart';
import 'widgets/session_menu_of_the_day.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      desktop: RecipePageDesktop(),
      mobile: RecipePageMobile(),
    );
  }
}

class RecipePageDesktop extends StatefulWidget {
  const RecipePageDesktop({super.key});

  @override
  State<RecipePageDesktop> createState() => _RecipePageDesktopState();
}

class _RecipePageDesktopState extends State<RecipePageDesktop> {
  late final RecipeBloc _blocRecipe;
  late final CategoryBloc _blocCategory;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _blocRecipe = Modular.get<RecipeBloc>();
    _blocCategory = Modular.get<CategoryBloc>();
    _blocRecipe.add(LoadGenericBlocEvent<RecipeEvent>());
    _blocCategory.add(LoadGenericBlocEvent<CategoryEvent>());
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalScaffoldWidget(
      controller: controller,
      body: BlocBuilder<RecipeBloc, GenericBlocState<RecipeState>>(
        bloc: _blocRecipe,
        builder: (context, state) {
          if (state is GenericBlocLoadingState<RecipeState>) {
            return const LoadingStateWidget();
          } else if (state
              is GenericBlocLoadedState<RecipeState, RecipeEntity>) {
            return Container(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        Responsive.maxWidthScreen(context) < 1500 ? 20 : 120,
                    vertical: 50),
                child: Responsive.maxWidthScreen(context) > 1500
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.only(right: 50),
                              color: Colors.transparent,
                              height: 869,
                              child: CategoryCheckBoxWidget(
                                categoryBloc: _blocCategory,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                SessionMenuOfTheDay(
                                  text: 'Cardápio do dia',
                                  subText:
                                      'Pratos do dia para aprender a fazer de forma fácil e pratica- clique em ver mais para outros opções',
                                  list: state.entityList,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : const SizedBox()
                // : Column(
                //     children: [
                //       Container(
                //         padding: const EdgeInsets.symmetric(horizontal: 60),
                //         color: Colors.transparent,
                //         // height: 869,
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               'Filtrar por tipo',
                //               style: theme.textTheme.bodyLarge!
                //                   .copyWith(fontWeight: FontWeight.bold),
                //             ),
                //             const Text('Categorias tipos'),
                //             const SizedBox(
                //               height: 20,
                //             ),
                //             Wrap(
                //               children: listCheckBox,
                //             )
                //           ],
                //         ),
                //       ),
                //       Container(
                //         color: Colors.transparent,
                //         child: Wrap(
                //           // runAlignment: WrapAlignment.spaceBetween,
                //           alignment: WrapAlignment.spaceBetween,
                //           spacing: 50,
                //           runSpacing: 20,
                //           // alignment: WrapAlignment.spaceAround,
                //           // runSpacing: 10,
                //           children:
                //               List.generate(state.entityList.length, (index) {
                //             RecipeEntity recipe = state.entityList[index];
                //             return CardWidget(
                //               image: NetworkImage(
                //                   '${BaseUrlApi.baseUrlMedia}${recipe.imageUrl}'),
                //               name: recipe.name,
                //               duration: recipe.timeToPrepare.toString(),
                //               category: recipe.category,
                //             );
                //           }),
                //         ),
                //       ),
                //     ],
                //   ),
                );
          } else if (state is GenericBlocErrorState<RecipeState>) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 120),
              child: ErrorStateWidget(
                message: state.message,
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

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
            style: theme.textTheme.bodySmall,
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
