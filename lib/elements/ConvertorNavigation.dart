import 'package:flutter/material.dart';
import 'package:unit_convertor/conversions.dart';

class ConvertorNavigation {
  static NavigationRail buildRail(List<Category> categories, int selectedIndex, Function onSelected) {
    return NavigationRail(
      
      destinations: getDestinations(categories),
      selectedIndex: selectedIndex + 1,
      onDestinationSelected: (value) {
        onSelected(value);
      },
      
    );
  }
  static List<NavigationRailDestination> getDestinations(List<Category> categories) {
    List<NavigationRailDestination> destinations = [
      NavigationRailDestination(icon: Icon(Icons.home), label: Text("Home"), selectedIcon: Icon(Icons.home))
    ];
    

    for(Category category in categories) {
      destinations.add(NavigationRailDestination(icon: Icon(category.outlined), 
      label: Text(category.category), selectedIcon: Icon(category.filled),
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0)));
    }
    return destinations;
  }
}