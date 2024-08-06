import 'package:kitchen_app/modules/recipe/01_domain/entities/ingredient_entity.dart';

class IngredientModel extends IngredientEntity {
  IngredientModel({required super.name, required super.moreInfo});

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      name: json['name'],
      moreInfo: json['more_info'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'more_info': moreInfo,
    };
  }
}
