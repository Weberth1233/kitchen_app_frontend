import 'package:kitchen_app/modules/recipe/01_domain/entities/step_entity.dart';

class StepModel extends StepEntity {
  StepModel({required super.description, required super.numberStep});

  factory StepModel.fromJson(Map<String, dynamic> json) {
    return StepModel(
      description: json['description'],
      numberStep: json['number_step'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'number_step': numberStep,
    };
  }
}
