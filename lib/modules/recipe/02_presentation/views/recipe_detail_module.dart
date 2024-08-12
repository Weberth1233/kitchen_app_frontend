import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:kitchen_app/modules/recipe/02_presentation/bloc/recipe_bloc/recipe_bloc_detail.dart';
import '../../../00_core_module/datasources/data_sources.dart';
import '../../../00_core_module/datasources/idata_sources.dart';
import '../../../00_core_module/repositories/irepository.dart';
import '../../../00_core_module/repositories/reposity.dart';
import '../../../00_core_module/usecase/iuse_case.dart';
import '../../../00_core_module/usecase/use_case.dart';
import '../../00_data/models/recipe_model.dart';
import '../../01_domain/entities/recipe_entity.dart';
import '../../category_module.dart';

class RecipeDetailModule extends Module {
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
    i.addSingleton<RecipeBlocDetail>(
      () => RecipeBlocDetail(
          useCase: i.get<IUseCase<RecipeEntity, NoParams, RecipeModel>>()),
    );
  }

  @override
  // TODO: implement imports
  List<Module> get imports => [CategoryModule()];
}