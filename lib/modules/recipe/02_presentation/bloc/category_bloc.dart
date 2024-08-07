import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../00_core_module/bloc/generic_bloc_event.dart';
import '../../../00_core_module/bloc/generic_bloc_state.dart';
import '../../../00_core_module/usecase/iuse_case.dart';
import '../../../00_core_module/utils/paths_name.dart';
import '../../00_data/models/category_model.dart';
import '../../01_domain/entities/category_entity.dart';

class CategoryBloc extends Bloc<GenericBlocEvent<CategoryEvent>,
    GenericBlocState<CategoryState>> {
  final IUseCase<CategoryEntity, NoParams, CategoryModel> useCase;

  CategoryBloc({required this.useCase})
      : super(GenericBlocInitialState<CategoryState>()) {
    on<LoadGenericBlocEvent<CategoryEvent>>(_onFetchedCategory);
  }

  Future<void> _onFetchedCategory(LoadGenericBlocEvent<CategoryEvent> event,
      Emitter<GenericBlocState<CategoryState>> emit) async {
    emit(GenericBlocLoadingState<CategoryState>());

    final result = await useCase.call(
      GetAllParams<CategoryModel>(
          table: PathsName.categorys, fromJson: categoryModelFromJson),
    );
    result.fold(
        (failure) => emit(GenericBlocErrorState<CategoryState>(
            message: 'Erro ao buscar os dados!')), (sucess) {
      sucess.sort(
        (a, b) => a.name.compareTo(b.name),
      );
      emit(
        GenericBlocLoadedState<CategoryState, CategoryEntity>(
            entityList: sucess),
      );
    });
  }
}

class CategoryEvent extends GenericBlocEvent {}

class CategoryState extends GenericBlocState {}
