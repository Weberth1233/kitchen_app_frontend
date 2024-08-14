import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import '../../../core_module/features/datasources/data_sources.dart';
import '../../../core_module/features/datasources/idata_sources.dart';
import '../../../core_module/features/repositories/irepository.dart';
import '../../../core_module/features/repositories/reposity.dart';
import '../../../core_module/features/usecase/iuse_case.dart';
import '../../../core_module/features/usecase/use_case.dart';
import '../../00_data/models/recipe_model.dart';
import '../../01_domain/entities/recipe_entity.dart';
import '../bloc/recipe_bloc/recipe_bloc_detail.dart';
import '../bloc/recipe_bloc/recipe_bloc_general.dart';
import '../bloc/recipe_bloc/recipe_bloc_random_recipe.dart';
import '../bloc/recipe_bloc/recipe_bloc_recipes_by_category.dart';
import 'pages/recipe_detail_page.dart';
import 'pages/recipe_page.dart';
import 'category_module.dart';

class RecipeModule extends Module {
  @override
  void binds(Injector i) {
    //Injetando a interface e o datasource implementação
    i.addSingleton<IDatasource<RecipeModel>>(
      () => DataSources<RecipeModel>(
        client: http.Client(),
      ),
    );
    i.addSingleton<IRepository<RecipeEntity, RecipeModel>>(
      () => Reposity<RecipeEntity, RecipeModel>(
        dataSourcesImpl: i.get<IDatasource<RecipeModel>>(),
      ),
    );
    i.addSingleton<IUseCase<RecipeEntity, NoParams, RecipeModel>>(
      () => UseCase<RecipeEntity, NoParams, RecipeModel>(
          reposity: i.get<IRepository<RecipeEntity, RecipeModel>>()),
    );
    i.addSingleton<RecipeBloc>(
      () => RecipeBloc(
          useCase: i.get<IUseCase<RecipeEntity, NoParams, RecipeModel>>()),
    );
    i.addSingleton<RecipeBlocRandomRecipe>(
      () => RecipeBlocRandomRecipe(
          useCase: i.get<IUseCase<RecipeEntity, NoParams, RecipeModel>>()),
    );
    i.add<RecipeBlocRecipesByCategory>(
      () => RecipeBlocRecipesByCategory(
          useCase: i.get<IUseCase<RecipeEntity, NoParams, RecipeModel>>()),
    );
    i.addSingleton<RecipeBlocDetail>(
      () => RecipeBlocDetail(
          useCase: i.get<IUseCase<RecipeEntity, NoParams, RecipeModel>>()),
    );
  }

  @override
  // TODO: implement imports
  List<Module> get imports => [CategoryModule()];

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const RecipePage(),
    );
    r.child('/recipe_detail/:id',
        child: ((context) => RecipeDetailPage(idRecipe: r.args.params['id'])),
        transition: TransitionType.fadeIn);
  }
}
