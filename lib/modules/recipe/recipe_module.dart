import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import '../00_core_module/datasources/data_sources.dart';
import '../00_core_module/datasources/idata_sources.dart';
import '../00_core_module/repositories/irepository.dart';
import '../00_core_module/repositories/reposity.dart';
import '../00_core_module/usecase/iuse_case.dart';
import '../00_core_module/usecase/use_case.dart';
import '00_data/models/recipe_model.dart';
import '01_domain/entities/recipe_entity.dart';
import '02_presentation/bloc/recipe_bloc.dart';
import '02_presentation/views/recipe_page.dart';
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
  }

  @override
  // TODO: implement imports
  List<Module> get imports => [CategoryModule()];

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const RecipePage());
  }
}
