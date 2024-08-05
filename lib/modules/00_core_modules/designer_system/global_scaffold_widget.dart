import 'package:flutter/material.dart';

class GlobalScaffoldWidget extends StatelessWidget {
  final String appBarTitle;
  final Widget body;
  final bool? centerTitle;
  final Color? backgroundColor;

  const GlobalScaffoldWidget({
    super.key,
    required this.appBarTitle,
    required this.body,
    this.centerTitle = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const TopHeader(),
          const BottomHeader(),
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
  const BottomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: 230,
      color: theme.colorScheme.secondary,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: const Center(
        child: SizedBox(
          width: 900,
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.close),
            ),
          ),
        ),
      ),
    );
  }
}
