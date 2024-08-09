import 'dart:convert';

import '../../01_domain/entities/recipe_entity.dart';
import 'category_model.dart';
import 'ingredient_model.dart';
import 'step_model.dart';

String recipeModelListToJson(List<RecipeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<RecipeModel> recipeModelFromJson(String str) => List<RecipeModel>.from(
    json.decode(str).map((x) => RecipeModel.fromJson(x)));

class RecipeModel extends RecipeEntity {
  final List<IngredientModel> ingredientsModel;
  final List<StepModel> stepsModel;

  RecipeModel({
    required super.id,
    required super.name,
    required super.category,
    required super.imageUrl,
    required super.timeToPrepare,
    required this.ingredientsModel,
    required this.stepsModel,
    required super.date,
  }) : super(
          ingredients: ingredientsModel,
          steps: stepsModel,
        );

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    var ingredientsList = json['ingredients'] as List;
    var stepsList = json['steps'] as List;
    var categoryJson = json['category'];

    List<IngredientModel> ingredientItems =
        ingredientsList.map((i) => IngredientModel.fromJson(i)).toList();
    List<StepModel> stepItems =
        stepsList.map((s) => StepModel.fromJson(s)).toList();
    CategoryModel category = CategoryModel.fromJson(categoryJson);

    return RecipeModel(
        id: json['id'],
        name: json['name'],
        category: category,
        imageUrl: json['image_url'],
        ingredientsModel: ingredientItems,
        stepsModel: stepItems,
        timeToPrepare: json['time_to_prepare'],
        date: json['created_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'image_url': imageUrl,
      'ingredients': ingredientsModel.map((i) => i.toJson()).toList(),
      'steps': stepsModel.map((s) => s.toJson()).toList(),
      'time_to_prepare': timeToPrepare,
      'created_at': date,
    };
  }
}
