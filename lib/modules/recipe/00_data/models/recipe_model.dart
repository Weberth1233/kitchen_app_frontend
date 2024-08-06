import 'dart:convert';

import 'package:kitchen_app/modules/recipe/00_data/models/step_model.dart';
import 'package:kitchen_app/modules/recipe/01_domain/entities/recipe_entity.dart';

import 'ingredient_model.dart';

String recipeModelListToJson(List<RecipeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<RecipeModel> recipeModelFromJson(String str) => List<RecipeModel>.from(
    json.decode(str).map((x) => RecipeModel.fromJson(x)));

class RecipeModel extends RecipeEntity {
  final List<IngredientModel> ingredientsModel;
  final List<StepModel> stepsModel;

  RecipeModel({
    required super.name,
    required super.category,
    required super.imageUrl,
    required this.ingredientsModel,
    required this.stepsModel,
  }) : super(
          ingredients: ingredientsModel,
          steps: stepsModel,
        );

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    var ingredientsList = json['ingredients'] as List;
    var stepsList = json['steps'] as List;

    List<IngredientModel> ingredientItems =
        ingredientsList.map((i) => IngredientModel.fromJson(i)).toList();
    List<StepModel> stepItems =
        stepsList.map((s) => StepModel.fromJson(s)).toList();

    return RecipeModel(
      name: json['name'],
      category: json['category'],
      imageUrl: json['image_url'],
      ingredientsModel: ingredientItems,
      stepsModel: stepItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'image_url': imageUrl,
      'ingredients': ingredientsModel.map((i) => i.toJson()).toList(),
      'steps': stepsModel.map((s) => s.toJson()).toList(),
    };
  }
}