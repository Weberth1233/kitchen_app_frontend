import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../recipe/02_presentation/views/widgets/category_check_box_widget.dart';
import '../../../recipe/02_presentation/views/widgets/session_data.dart';
import '../../utils/responsive.dart';

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset('animation/loading.json'));
  }
}

class LoadingTest extends StatelessWidget {
  const LoadingTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: Responsive.maxWidthScreen(context) < 1500 ? 20 : 120,
            vertical: 50),
        child: Responsive.maxWidthScreen(context) > 1500
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(right: 50),
                      color: Colors.transparent,
                      height: 869,
                      child: const CategoryCheckBoxWidget(),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [],
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
  }
}
