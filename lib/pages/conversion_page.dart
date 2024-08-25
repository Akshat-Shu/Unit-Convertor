import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unit_convertor/elements/ConvertorNavigation.dart';
import 'package:unit_convertor/conversions.dart';

class ConversionPage extends StatefulWidget{
  ConversionPage({super.key, this.categoryIndex = 0});
  final int categoryIndex;

  State<ConversionPage> createState() => _ConversionPageState(categoryIndex);
}

class _ConversionPageState extends State<ConversionPage> {
  _ConversionPageState(this.selectedCategoryIndex);
  int selectedCategoryIndex;
  Category selectedCategory = categories[1];
  var selectedUnit1 = null;
  var givenInput;
  var output;
  String message = "";
  TextEditingController outputController = TextEditingController();
  var selectedUnit2 = null;

  Widget build(BuildContext ctx) {
    final theme = Theme.of(ctx);
    final headingLargeStyle = theme.textTheme.headlineLarge!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
      fontSize: 45.0
    );
    selectedCategory = categories[selectedCategoryIndex];
    message = makeMessage(givenInput, selectedUnit1, selectedUnit2, selectedCategory, output);
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: ConvertorNavigation.buildRail(categories, selectedCategoryIndex, (value) => setState(() {
              Navigator.pop(ctx);
              if(value != 0) {
                Navigator.push(ctx, MaterialPageRoute(builder:(context) => ConversionPage(categoryIndex: value - 1,),));
              }
            })),
          ),
          Expanded(child: 
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text("Unit Convetor for ${selectedCategory.category}", style: headingLargeStyle, textAlign: TextAlign.center,),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 200.0,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              givenInput = double.tryParse(value);
                              output = convertUnits(selectedCategory, givenInput, selectedUnit1, selectedUnit2);
                              message = makeMessage(givenInput, selectedUnit1, selectedUnit2, selectedCategory, output);
                            });
                          },
                          enableSuggestions: false,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: "Value you want to convert",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*\.?[0-9]*$'))
                          ],
                        ),
                      ),
                      Text(shortForms[selectedCategory.category]?[selectedUnit1] ?? "", style: theme.textTheme.labelLarge,)
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text('Convert from: ', style: theme.textTheme.bodyLarge,),
                        DropdownMenu(
                          dropdownMenuEntries: getEntries(categories[selectedCategoryIndex]),
                          onSelected: (value) {
                            setState(() {
                              selectedUnit1 = value;
                              output = convertUnits(selectedCategory, givenInput, selectedUnit1, selectedUnit2);
                              message = makeMessage(givenInput, selectedUnit1, selectedUnit2, selectedCategory, output);
                            });
                          },
                          initialSelection: selectedUnit1,
                        ),
                        
                      ],
                      
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: ElevatedButton(onPressed: () {
                      setState(() {
                        var temp = selectedUnit1;
                        selectedUnit1 = selectedUnit2;
                        selectedUnit2 = temp;
                        output = convertUnits(selectedCategory, givenInput, selectedUnit1, selectedUnit2);
                      });
                    }, child: Icon(Icons.swap_horiz_rounded),
                    
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 200.0,
                        child: TextField(
                          controller: TextEditingController(text: output == null ? "The converted value" : output.toString()),
                          enableSuggestions: false,
                          textAlign: TextAlign.center,
                          enabled: false,
                          style: TextStyle(color: const Color.fromARGB(221, 36, 36, 36)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(shortForms[selectedCategory.category]?[selectedUnit2] ?? "", style: theme.textTheme.labelLarge,),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text('Convert to: ', style: theme.textTheme.bodyLarge,),
                        DropdownMenu(
                          dropdownMenuEntries: getEntries(categories[selectedCategoryIndex]),
                          onSelected: (value) {
                            setState(() {
                              selectedUnit2 = value;
                              output = convertUnits(selectedCategory, givenInput, selectedUnit1, selectedUnit2);
                              message = makeMessage(givenInput, selectedUnit1, selectedUnit2, selectedCategory, output);
                            });
                          },
                          initialSelection: selectedUnit2,
                        ),
                        
                      ],
                      
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(message, style: theme.textTheme.titleMedium,),
                  )
                ],
              )
            )
          )
        ],
      ),
      backgroundColor: theme.colorScheme.primaryContainer,
    );
  }
}

List<DropdownMenuEntry> getEntries(Category category) {
  List<DropdownMenuEntry> entries = [];
  for(String key in conversions[category.category]!.keys) {
    entries.add(
      DropdownMenuEntry(value: key, label: key)
    );
  }
  return entries;
}

double? convertUnits(Category unitCategory, double? inputValue, String? from, String? to) {
  if (inputValue == null || from == null || to == null) return null;
  if(unitCategory.categoryIndex < categories.length - 1) {
    num? multiplier = conversions[unitCategory.category]![from];
    num? divisor = conversions[unitCategory.category]![to];
    if(multiplier == null || divisor == null) return null;
    return inputValue *  multiplier/ divisor;
  } else {
    Function? convertBack = fromCelcius[to];
    Function? convertTo = toCelcius[from];
    if(convertBack == null || convertTo == null) return null;
    return convertBack(convertTo(inputValue));
  }
}

String makeMessage(num? inputValue, String? from, String? to, Category ctgry, num? output) {
  if(inputValue == null) return "Please provide the value you want to convert";
  if(from == null) return "Please provide the unit you want to convert from";
  if(to == null) return "Please provide the unit you want to convert to";
  return "${inputValue.toString()} ${shortForms[ctgry.category]![from]} = ${output.toString()} ${shortForms[ctgry.category]![to]}";
}