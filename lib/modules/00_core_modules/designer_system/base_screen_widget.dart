import 'package:flutter/material.dart';
import 'forms_widgets/button_widget.dart';
import 'forms_widgets/text_input_widget.dart';
import 'global_scaffold_widget.dart';

class BaseScreenWidget extends StatelessWidget {
  final String appBarTitle;
  final String title;
  final String subTitle;
  final List<TextInputWidget> textInputWidgetList;
  final String textButton;
  final void Function()? onPressed;

  const BaseScreenWidget({
    super.key,
    required this.appBarTitle,
    required this.title,
    required this.subTitle,
    required this.textInputWidgetList,
    required this.textButton,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlobalScaffoldWidget(
      appBarTitle: appBarTitle,
      body: Container(
        color: theme.colorScheme.background,
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 35,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: theme.textTheme.headlineMedium!
                  .copyWith(color: theme.colorScheme.primary),
            ),
            Text(
              subTitle,
              style: theme.textTheme.bodySmall!
                  .copyWith(color: theme.colorScheme.outline),
            ),
            const SizedBox(
              height: 62,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: textInputWidgetList.length,
                      itemBuilder: (context, index) {
                        return textInputWidgetList[index];
                      },
                    ),
                  ),
                  ButtonWidget(
                    textButton: textButton,
                    onPressed: onPressed,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
