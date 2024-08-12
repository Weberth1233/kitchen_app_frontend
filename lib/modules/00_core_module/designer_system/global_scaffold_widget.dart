import 'package:flutter/material.dart';

import '../../recipe/02_presentation/bloc/recipe_bloc/recipe_bloc_general.dart';
import '../../recipe/02_presentation/bloc/recipe_event.dart';
import '../bloc/generic_bloc_event.dart';
import '../utils/responsive.dart';

class GlobalScaffoldWidget extends StatelessWidget {
  final Widget body;
  final Color? backgroundColor;
  final RecipeBloc? bloc;

  final TextEditingController? controller;

  const GlobalScaffoldWidget({
    super.key,
    required this.body,
    this.backgroundColor,
    this.controller,
    this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const TopHeader(),
          bloc != null
              ? BottomHeader(
                  controller: controller!,
                  bloc: bloc!,
                )
              : const SizedBox(),
          body,
        ],
      ),
    );
  }
}

class TopHeader extends StatelessWidget {
  const TopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      color: theme.colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            width: 173,
            height: 90,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(
                  'assets/images/LOGO.png',
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'RECEITAS',
              style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'CATEGORIAS',
              style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'SOBRE NÓS',
              style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomHeader extends StatelessWidget {
  final TextEditingController controller;
  final RecipeBloc bloc;
  const BottomHeader({super.key, required this.controller, required this.bloc});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final ctrl = Get.find<TextFieldController>();

    return Container(
      width: double.infinity,
      height: 400,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.darken),
            image: const AssetImage('assets/images/Image.png'),
            fit: BoxFit.fitWidth,
            filterQuality: FilterQuality.high),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Qual receita deseja encontrar hoje ?',
            style: Responsive.isMobile(context)
                ? theme.textTheme.headlineSmall!.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold)
                : theme.textTheme.displayMedium!.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 800,
            child: TextField(
              controller: controller,
              onChanged: (value) {
                bloc.add(LoadGenericPaginatedBlocEvent<RecipeEvent>(
                  params: {
                    "page": 1,
                    "name": value,
                  },
                  filter: true,
                ));
                // ctrl.writingText(value);
              },
              style: TextStyle(color: theme.colorScheme.primary),
              decoration: InputDecoration(
                prefixIcon: Container(
                    padding: const EdgeInsets.only(left: 12),
                    child: const Icon(Icons.search)),
                suffixIcon: Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: const Icon(Icons.close)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
