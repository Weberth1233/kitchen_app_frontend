import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core_module/features/bloc/generic_bloc_event.dart';
import '../../../../core_module/features/bloc/generic_bloc_state.dart';
import '../../../../core_module/designer_system/global_scaffold_widget.dart';

import '../../../../core_module/utils/responsive.dart';

import '../../bloc/recipe_bloc/recipe_bloc_general.dart';

import '../widgets/category_check_box_widget.dart';
import '../widgets/session_menu_of_the_day_recipe.dart';
import '../widgets/session_menu_recipe_category_candys.dart';
import '../widgets/session_menu_recipe_category_drinks.dart';
import '../widgets/session_random_recipe.dart';
import 'mobile/recipe_mobile.dart';

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
  // late final CategoryBloc _blocCategory;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _blocRecipe = Modular.get<RecipeBloc>();
    _blocRecipe.add(
        // LoadGenericBlocEvent<RecipeEvent>(),
        LoadGenericPaginatedBlocEvent(params: const {
      'page': 1,
    }));
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
        bloc: _blocRecipe,
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.maxWidthScreen(context) < 1500 ? 20 : 120,
              vertical: 50),
          child: Responsive.maxWidthScreen(context) > 1000
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(right: 50),
                        color: Colors.transparent,
                        height: 869,
                        child: CategoryCheckBoxWidget(
                          blocRecipe: _blocRecipe,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          SessionMenuOfTheDayRecipe(
                            text: 'Pratos Para Todos os Gostos',
                            subText:
                                'Aprenda a fazer receitas saborosas e práticas em poucos minutos. Clique em "ver mais" para mais sugestões!',
                            blocRecipe: _blocRecipe,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const SessionRandomRecipe(),
                          const SizedBox(
                            height: 80,
                          ),
                          const SessionMenuRecipeDrinks(),
                          const SizedBox(
                            height: 80,
                          ),
                          const SessionMenuRecipeCandys(),
                        ],
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ));
  }
}
