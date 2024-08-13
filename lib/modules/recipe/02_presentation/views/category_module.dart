import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import '../../../core_module/features/datasources/data_sources.dart';
import '../../../core_module/features/datasources/idata_sources.dart';
import '../../../core_module/features/repositories/irepository.dart';
import '../../../core_module/features/repositories/reposity.dart';
import '../../../core_module/features/usecase/iuse_case.dart';
import '../../../core_module/features/usecase/use_case.dart';
import '../../00_data/models/category_model.dart';
import '../../01_domain/entities/category_entity.dart';
import '../bloc/category_bloc/category_bloc.dart';

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
