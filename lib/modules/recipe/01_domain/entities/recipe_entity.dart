import 'ingredient_entity.dart';
import 'step_entity.dart';

class RecipeEntity {
  final String name;
  final int category;
  final String imageUrl;
  final List<IngredientEntity> ingredients;
  final List<StepEntity> steps;

  RecipeEntity({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
  });
}
