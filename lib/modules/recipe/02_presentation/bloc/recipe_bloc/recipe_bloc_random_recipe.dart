import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_app/modules/00_core_module/usecase/iuse_case.dart';
import 'package:kitchen_app/modules/00_core_module/utils/paths_name.dart';
import 'package:kitchen_app/modules/recipe/00_data/models/recipe_model.dart';
import 'package:kitchen_app/modules/recipe/01_domain/entities/recipe_entity.dart';
import '../../../../00_core_module/bloc/generic_bloc_event.dart';
import '../../../../00_core_module/bloc/generic_bloc_state.dart';
import '../recipe_event.dart';
import '../recipe_state.dart';

class RecipeBlocRandomRecipe
    extends Bloc<GenericBlocEvent<RecipeEvent>, GenericBlocState<RecipeState>> {
  final IUseCase<RecipeEntity, NoParams, RecipeModel> useCase;

  RecipeBlocRandomRecipe({required this.useCase})
      : super(GenericBlocInitialState<RecipeState>()) {
    on<RecipeRandomEvent<RecipeEvent>>(_onFetchedRecipeRandom);
  }

  Future<void> _onFetchedRecipeRandom(RecipeRandomEvent<RecipeEvent> event,
      Emitter<GenericBlocState<RecipeState>> emit) async {
    emit(GenericBlocLoadingState<RecipeState>());

    final result = await useCase.entity(
      GetEntityParams<RecipeModel>(
        table: PathsName.recipeRandom,
        fromJson: RecipeModel.fromJson,
      ),
    );
    result.fold(
        (failure) => emit(GenericBlocErrorState<RecipeState>(
            message: 'Erro ao buscar os dados!')), (sucess) {
      emit(
        GenericBlocLoadedEntityState<RecipeState, RecipeEntity>(entity: sucess),
      );
    });
  }
}

class RecipeRandomEvent<R> extends GenericBlocEvent<R> {
  RecipeRandomEvent();
}
