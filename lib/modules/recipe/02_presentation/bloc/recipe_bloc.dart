import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_app/modules/00_core_modules/usecase/iuse_case.dart';
import 'package:kitchen_app/modules/00_core_modules/utils/paths_name.dart';
import 'package:kitchen_app/modules/recipe/00_data/models/recipe_model.dart';
import 'package:kitchen_app/modules/recipe/01_domain/entities/recipe_entity.dart';
import '../../../00_core_modules/bloc/generic_bloc_event.dart';
import '../../../00_core_modules/bloc/generic_bloc_state.dart';

class RecipeBloc
    extends Bloc<GenericBlocEvent<RecipeEvent>, GenericBlocState<RecipeState>> {
  final IUseCase<RecipeEntity, NoParams, RecipeModel> useCase;

  RecipeBloc({required this.useCase})
      : super(GenericBlocInitialState<RecipeState>()) {
    on<LoadGenericBlocEvent<RecipeEvent>>(_onFetchedRecipe);
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
}

class RecipeEvent extends GenericBlocEvent {}

class RecipeState extends GenericBlocState {}