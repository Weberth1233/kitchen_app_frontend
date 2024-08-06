import 'package:dartz/dartz.dart';
import 'package:kitchen_app/modules/00_core_modules/failures/failures.dart';
import 'package:kitchen_app/modules/recipe/01_domain/entities/recipe_entity.dart';

abstract class RecipeRepository {
  Future<Either<Failure, RecipeEntity>> fetchRecipe();
}
