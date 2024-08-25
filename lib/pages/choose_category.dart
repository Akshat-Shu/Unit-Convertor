import 'package:flutter/material.dart';
import 'package:unit_convertor/conversions.dart';
import 'package:unit_convertor/elements/categoryGrid.dart';

class ChooseCategoryPage extends StatelessWidget {
  const ChooseCategoryPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  Widget build(BuildContext ctx) {
    final theme = Theme.of(ctx);
    final headingLargeStyle = theme.textTheme.headlineLarge!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
      fontSize: 45.0
    );
    final headingMediumStyle = theme.textTheme.headlineMedium!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,

    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 50.0),
              child: Text('Unit Convertor', style: headingLargeStyle,),
            ),
            Icon(Icons.scale, size: 250.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 0.0),
              child: Text('Choose which Kind of Value you want to convert', style: headingMediumStyle, textAlign: TextAlign.center,),
            ),
            CategoryGrid.formColumn(categories, theme, ctx)
          ],
        ),
      ),
      backgroundColor: theme.colorScheme.primaryContainer,
    );
  }
}

