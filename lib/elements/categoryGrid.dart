import 'package:flutter/material.dart';
import 'package:unit_convertor/conversions.dart';
import 'package:unit_convertor/pages/conversion_page.dart';

class CategoryGrid  {
  static Column formColumn(List<Category> categories, ThemeData theme, BuildContext ctx) {
    List<Row> rows = [];
    List<Widget> listElements = [];

    for(int i = 0; i < categories.length; i++) {
      listElements.add(
        _buildCategoryButton(categories[i], theme, ctx)
      );

      if(i % 3 == 2 || i == categories.length - 1) {
        rows.add(Row(children: listElements, mainAxisAlignment: MainAxisAlignment.center,));
        listElements = [];
      }
    }
    return Column(children: rows, mainAxisAlignment: MainAxisAlignment.center,);
  }


  static Widget _buildCategoryButton(Category category, ThemeData theme, BuildContext ctx) {
    return GestureDetector(
      onTap: () {
        Navigator.push(ctx, MaterialPageRoute(builder: (context) => ConversionPage(categoryIndex: category.categoryIndex)));
      },
      child: Container(
        margin: EdgeInsets.all(7.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: theme.colorScheme.tertiaryContainer,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(category.filled, size: 40.0),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(category.category, style: theme.textTheme.bodyLarge,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}