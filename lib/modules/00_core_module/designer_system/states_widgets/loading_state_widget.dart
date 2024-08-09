import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../utils/responsive.dart';

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset('animation/loading.json'));
  }
}

class LoadingTest extends StatelessWidget {
  const LoadingTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.maxWidthScreen(context) < 1500 ? 20 : 120,
          vertical: 50),
      child: const CircularProgressIndicator.adaptive(),
    );
  }
}
