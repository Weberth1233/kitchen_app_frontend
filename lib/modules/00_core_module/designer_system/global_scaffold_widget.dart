import 'package:flutter/material.dart';
import 'package:kitchen_app/modules/00_core_module/utils/responsive.dart';

class GlobalScaffoldWidget extends StatelessWidget {
  final Widget body;
  final Color? backgroundColor;

  final TextEditingController controller;

  const GlobalScaffoldWidget({
    super.key,
    required this.body,
    this.backgroundColor,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const TopHeader(),
          BottomHeader(controller: controller),
          body,
        ],
      ),
    );
  }
}

class TopHeader extends StatelessWidget {
  const TopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      color: theme.colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            width: 173,
            height: 90,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(
                  'assets/images/LOGO.png',
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'RECEITAS',
              style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'CATEGORIAS',
              style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'SOBRE NÓS',
              style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomHeader extends StatelessWidget {
  final TextEditingController controller;
  const BottomHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: 340,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.darken),
            image: const AssetImage('assets/images/Image.png'),
            fit: BoxFit.fitWidth,
            filterQuality: FilterQuality.high),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Qual receita deseja encontrar hoje ?',
            style: Responsive.isMobile(context)
                ? theme.textTheme.headlineSmall!.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold)
                : theme.textTheme.displayMedium!.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 800,
            child: TextField(
              controller: controller,
              onChanged: (value) {
                print(value);
              },
              style: TextStyle(color: theme.colorScheme.primary),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.close),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
