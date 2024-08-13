import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_app/modules/core_module/features/usecase/iuse_case.dart';
import 'package:kitchen_app/modules/core_module/utils/paths_name.dart';
import 'package:kitchen_app/modules/recipe/00_data/models/recipe_model.dart';
import 'package:kitchen_app/modules/recipe/01_domain/entities/recipe_entity.dart';
import '../../../../core_module/features/bloc/generic_bloc_event.dart';
import '../../../../core_module/features/bloc/generic_bloc_state.dart';
import '../recipe_event.dart';
import '../recipe_state.dart';

class RecipeBloc
    extends Bloc<GenericBlocEvent<RecipeEvent>, GenericBlocState<RecipeState>> {
  final IUseCase<RecipeEntity, NoParams, RecipeModel> useCase;

  RecipeBloc({required this.useCase})
      : super(GenericBlocInitialState<RecipeState>()) {
    on<LoadGenericBlocEvent<RecipeEvent>>(_onFetchedRecipe);
    on<LoadGenericPaginatedBlocEvent<RecipeEvent>>(_onFetchedRecipePaginated);
    on<RecipeByCategoryEventAll<RecipeEvent>>(_onFetchedRecipeByCategoryAll);
  }

  Future<void> _onFetchedRecipe(LoadGenericBlocEvent<RecipeEvent> event,
      Emitter<GenericBlocState<RecipeState>> emit) async {
    emit(GenericBlocLoadingState<RecipeState>());

    final result = await useCase.call(
      GetAllParams<RecipeModel>(
          table: PathsName.recipes, fromJson: recipeModelFromJson),
    );
    result.fold(
        (failure) => emit(GenericBlocErrorState<RecipeState>(
            message: 'Erro ao buscar os dados!')), (sucess) {
      sucess.sort(
        (a, b) => a.name.compareTo(b.name),
      );
      emit(
        GenericBlocLoadedState<RecipeState, RecipeEntity>(entityList: sucess),
      );
    });
  }

  Future<void> _onFetchedRecipeByCategoryAll(
      RecipeByCategoryEventAll<RecipeEvent> event,
      Emitter<GenericBlocState<RecipeState>> emit) async {
    emit(GenericBlocLoadingState<RecipeState>());

    final result = await useCase.call(
      GetAllParams<RecipeModel>(
          table: PathsName.recipesCategoryFilter,
          fromJson: recipeModelFromJson,
          mapParams: {"categorys": event.categorys}),
    );
    result.fold(
        (failure) => emit(GenericBlocErrorState<RecipeState>(
            message: 'Erro ao buscar os dados!')), (sucess) {
      sucess.sort(
        (a, b) => a.name.compareTo(b.name),
      );
      if (event.categorys.isEmpty) {
        add(
          LoadGenericPaginatedBlocEvent<RecipeEvent>(
            params: const {
              "page": 1,
            },
          ),
        );
      }
      emit(
        GenericBlocLoadedState<RecipeState, RecipeEntity>(entityList: sucess),
      );
    });
  }

  Future<void> _onFetchedRecipePaginated(
      LoadGenericPaginatedBlocEvent<RecipeEvent> event,
      Emitter<GenericBlocState<RecipeState>> emit) async {
    emit(GenericBlocLoadingState<RecipeState>());

    final result = await useCase.call(
      GetAllParams<RecipeModel>(
        table: event.filter
            ? PathsName.filterNameRecipe
            : PathsName.recipePaginationAll,
        fromJson: recipeModelFromJson,
        mapParams: event.params,
      ),
    );
    result.fold(
        (failure) => emit(GenericBlocErrorState<RecipeState>(
            message: 'Erro ao buscar os dados!')), (sucess) {
      sucess.sort(
        (a, b) => a.name.compareTo(b.name),
      );
      if (sucess.isEmpty) {
        emit(GenericBlocNoDataState<RecipeState>());
      } else {
        emit(
          GenericBlocLoadedState<RecipeState, RecipeEntity>(entityList: sucess),
        );
      }
    });
  }
}

class RecipeByCategoryEventAll<R> extends GenericBlocEvent<R> {
  final List<int> categorys;

  RecipeByCategoryEventAll({required this.categorys});
}
