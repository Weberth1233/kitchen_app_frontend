import 'package:kitchen_app/modules/recipe/01_domain/entities/category_entity.dart';

import 'ingredient_entity.dart';
import 'step_entity.dart';

class RecipeEntity {
  final int id;
  final String name;
  final CategoryEntity category;
  final String imageUrl;
  final List<IngredientEntity> ingredients;
  final List<StepEntity> steps;
  final int timeToPrepare;
  final String date;

  RecipeEntity(
      {required this.id,
      required this.name,
      required this.category,
      required this.imageUrl,
      required this.ingredients,
      required this.steps,
      required this.timeToPrepare,
      required this.date});
}
