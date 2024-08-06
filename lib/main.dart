import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kitchen_app/modules/recipe/02_presentation/views/recipe_page.dart';
import 'package:kitchen_app/modules/recipe/recipe_module.dart';

import 'modules/00_core_modules/theme/theme.dart';

void main() {
  runApp(ModularApp(module: RecipeModule(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: Modular.routerConfig,
    );
  }
}
