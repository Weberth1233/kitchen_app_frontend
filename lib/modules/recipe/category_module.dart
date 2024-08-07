import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import '../00_core_module/datasources/data_sources.dart';
import '../00_core_module/datasources/idata_sources.dart';
import '../00_core_module/repositories/irepository.dart';
import '../00_core_module/repositories/reposity.dart';
import '../00_core_module/usecase/iuse_case.dart';
import '../00_core_module/usecase/use_case.dart';
import '00_data/models/category_model.dart';
import '01_domain/entities/category_entity.dart';
import '02_presentation/bloc/category_bloc.dart';

class CategoryModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton<IDatasource<CategoryModel>>(
      () => DataSources<CategoryModel>(
        client: http.Client(),
      ),
    );
    i.addSingleton<IRepository<CategoryEntity, CategoryModel>>(
      () => Reposity<CategoryEntity, CategoryModel>(
        dataSourcesImpl: i.get<IDatasource<CategoryModel>>(),
      ),
    );
    i.addSingleton<IUseCase<CategoryEntity, NoParams, CategoryModel>>(
      () => UseCase<CategoryEntity, NoParams, CategoryModel>(
          reposity: i.get<IRepository<CategoryEntity, CategoryModel>>()),
    );
    i.addSingleton<CategoryBloc>(
      () => CategoryBloc(
          useCase: i.get<IUseCase<CategoryEntity, NoParams, CategoryModel>>()),
    );
  }
}
