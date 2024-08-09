import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_app/modules/00_core_module/usecase/iuse_case.dart';
import 'package:kitchen_app/modules/00_core_module/utils/paths_name.dart';
import 'package:kitchen_app/modules/recipe/00_data/models/recipe_model.dart';
import 'package:kitchen_app/modules/recipe/01_domain/entities/recipe_entity.dart';
import '../../../00_core_module/bloc/generic_bloc_event.dart';
import '../../../00_core_module/bloc/generic_bloc_state.dart';

class RecipeBloc
    extends Bloc<GenericBlocEvent<RecipeEvent>, GenericBlocState<RecipeState>> {
  final IUseCase<RecipeEntity, NoParams, RecipeModel> useCase;

  RecipeBloc({required this.useCase})
      : super(GenericBlocInitialState<RecipeState>()) {
    on<LoadGenericBlocEvent<RecipeEvent>>(_onFetchedRecipe);
    on<LoadGenericPaginatedBlocEvent<RecipeEvent>>(_onFetchedRecipePaginated);
    on<RecipeByCategoryEvent<RecipeEvent>>(_onFetchedRecipeByCategory);
    on<RecipeRandomEvent<RecipeEvent>>(_onFetchedRecipeRandom);
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

  Future<void> _onFetchedRecipeRandom(RecipeRandomEvent<RecipeEvent> event,
      Emitter<GenericBlocState<RecipeState>> emit) async {
    emit(GenericBlocLoadingState<RecipeState>());

    final result = await useCase.entity(
      GetEntityParams<RecipeModel>(
          table: PathsName.recipeRandom, fromJson: RecipeModel.fromJson),
    );
    result.fold(
        (failure) => emit(GenericBlocErrorState<RecipeState>(
            message: 'Erro ao buscar os dados!')), (sucess) {
      emit(
        GenericBlocLoadedEntityState<RecipeState, RecipeEntity>(entity: sucess),
      );
    });
  }

  Future<void> _onFetchedRecipeByCategory(
      RecipeByCategoryEvent<RecipeEvent> event,
      Emitter<GenericBlocState<RecipeState>> emit) async {
    emit(GenericBlocLoadingState<RecipeState>());

    final result = await useCase.call(
      GetAllParams<RecipeModel>(
          table: '${PathsName.recipesCategory}${event.idCategory}',
          fromJson: recipeModelFromJson),
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

  Future<void> _onFetchedRecipePaginated(
      LoadGenericPaginatedBlocEvent<RecipeEvent> event,
      Emitter<GenericBlocState<RecipeState>> emit) async {
    emit(GenericBlocLoadingState<RecipeState>());

    final result = await useCase.call(
      GetAllParams<RecipeModel>(
        table: event.filter
            ? PathsName.filterNameRecipe
            : PathsName.recentlyRecipePagination,
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

class RecipeEvent<R> extends GenericBlocEvent<R> {}

class RecipeByCategoryEvent<R> extends GenericBlocEvent<R> {
  final int idCategory;

  RecipeByCategoryEvent({required this.idCategory});
}

class RecipeRandomEvent<R> extends GenericBlocEvent<R> {
  RecipeRandomEvent();
}

class RecipeState extends GenericBlocState {
  final List<RecipeEntity> theDayRecipe;
  final List<RecipeEntity> newRecipe;

  RecipeState({
    required this.theDayRecipe,
    required this.newRecipe,
  });
}
