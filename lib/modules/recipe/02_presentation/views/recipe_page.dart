import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitchen_app/modules/00_core_modules/designer_system/global_scaffold_widget.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlobalScaffoldWidget(
      appBarTitle: 'Comida',
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 50),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 800) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(right: 50),
                      color: Colors.transparent,
                      height: 869,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Filtrar por tipo',
                            style: theme.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Text('Categorias tipos - '),
                          const SizedBox(
                            height: 20,
                          ),
                          const RowCheckBox(
                            text: 'Fitness',
                          ),
                          const RowCheckBox(
                            text: 'Família brasileira',
                          ),
                          const RowCheckBox(
                            text: 'Churrasco de domingo',
                          ),
                          const RowCheckBox(
                            text: 'Japonesa',
                          ),
                          const RowCheckBox(
                            text: 'Chinesa',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      color: Colors.transparent,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Wrap(
                            spacing: 50,
                            runSpacing: 20,
                            children: [
                              Container(
                                height: 485,
                                width: 404,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/images/donuts.jpg',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Donnuts(American Food)',
                                      style: theme.textTheme.headlineMedium,
                                    ),
                                    Text(
                                      'Duração: 30 minutos',
                                      style: theme.textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 485,
                                width: 404,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/images/baked.png',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Donnuts(American Food)',
                                      style: theme.textTheme.headlineMedium,
                                    ),
                                    Text(
                                      'Duração: 30 minutos',
                                      style: theme.textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 485,
                                width: 404,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/images/chicken.png',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Chicken Makhani (Indian Butter Chicken)',
                                      style: theme.textTheme.headlineMedium,
                                    ),
                                    Text(
                                      'Duração: 30 minutos',
                                      style: theme.textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class RowCheckBox extends StatelessWidget {
  final String text;
  final void Function(bool?)? onChanged;
  final bool? value;
  const RowCheckBox({
    super.key,
    required this.text,
    this.onChanged,
    this.value = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(text),
        ),
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.green,
        ),
      ],
    ).paddingOnly(bottom: 12);
  }
}
