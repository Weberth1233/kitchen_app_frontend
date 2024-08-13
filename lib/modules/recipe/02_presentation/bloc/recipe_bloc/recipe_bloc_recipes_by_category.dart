import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_app/modules/core_module/features/usecase/iuse_case.dart';
import 'package:kitchen_app/modules/core_module/utils/paths_name.dart';
import 'package:kitchen_app/modules/recipe/00_data/models/recipe_model.dart';
import 'package:kitchen_app/modules/recipe/01_domain/entities/recipe_entity.dart';
import '../../../../core_module/features/bloc/generic_bloc_event.dart';
import '../../../../core_module/features/bloc/generic_bloc_state.dart';
import '../recipe_event.dart';
import '../recipe_state.dart';

class RecipeBlocRecipesByCategory
    extends Bloc<GenericBlocEvent<RecipeEvent>, GenericBlocState<RecipeState>> {
  final IUseCase<RecipeEntity, NoParams, RecipeModel> useCase;

  RecipeBlocRecipesByCategory({required this.useCase})
      : super(GenericBlocInitialState<RecipeState>()) {
    on<RecipeByCategoryEvent<RecipeEvent>>(_onFetchedRecipeByCategory);
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
}

class RecipeByCategoryEvent<R> extends GenericBlocEvent<R> {
  final int idCategory;

  RecipeByCategoryEvent({required this.idCategory});
}
