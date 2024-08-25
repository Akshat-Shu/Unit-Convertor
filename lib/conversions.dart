import 'package:flutter/material.dart';
final conversions = {
  'Volume': {
    'Litres': 1,
    'milliLitres': 0.001,
    'Cubic Metres': 1000,
    'Cubic Inches': 1.639e-2,
    'Gallon': 3.785,
    'Cubic Foot': 28.316,
  },
  'Length': {
    'milliMetres': 0.001,
    'centiMetres': 0.01,
    'kiloMetres': 1000,
    'Metres': 1,
    'Inches': 2.54e-2,
    'Feet': 0.3048,
    'Miles': 1609.344,
  },
  'Mass': {
    'milliGrams': 0.001,
    'Grams': 1,
    'kiloGrams': 1000,
    'Stone': 6350.29,
    'Pounds': 453.592,
    'Ounce': 28.3495,
  },
  'Time': {
    'Minutes': 60,
    'Seconds': 1,
    'Hours': 3600,
    'Days': 86400,
    'Weeks': 7*86400,
    'Years': 365*86400,
  },
  'Energy': {
    'British Thermal Units': 1055,
    'Ergs': 1e-7,
    'Joules': 1,
    'Foot-Pounds': 1.356,
    'Calories': 4.186,
    'KiloWatt-Hour': 3.6e6,
    'Litre-Atm.': 101.13,
  },
  'Area': {
    'Sq. Inches': 6.4516e-4,
    'Sq. Feet': 9.2903e-2,
    'Acres': 4.0468e3,
    'Hectares': 1e4,
    'Sq. Miles': 2.5888e6,
    'Sq. Metres': 1,
  },
  'Force': {
    'Newtons': 1,
    'Dynes': 1e-5,
    'Pounds': 4.448
  },
  'Temperature': {
    'Celcius': 0,
    'Farenheit': 0,
    'Reaumer': 0,
    'Kelvin': 0,
  }
};

final Map<String, Map<String, String>> shortForms = {
  'Volume': {
    'Litres': 'L',
    'milliLitres': 'mL',
    'Cubic Metres': 'm³',
    'Cubic Inches': 'in³',
    'Gallon': 'gal',
    'Cubic Foot': 'ft³',
  },
  'Length': {
    'milliMetres': 'mm',
    'centiMetres': 'cm',
    'kiloMetres': 'km',
    'Metres': 'm',
    'Inches': 'in',
    'Feet': 'ft',
    'Miles': 'mil',
  },
  'Mass': {
    'milliGrams': 'mg',
    'Grams': 'g',
    'kiloGrams': 'kg',
    'Stone': 'st',
    'Pounds': 'lbs',
    'Ounce': 'oz',
  },
  'Time': {
    'Minutes': 'm',
    'Seconds': 's',
    'Hours': 'h',
    'Days': 'days',
    'Weeks': 'wk',
    'Years': 'yr',
  },
  'Energy': {
    'British Thermal Units': 'BTU',
    'Ergs': 'Erg',
    'Joules': 'J',
    'Foot-Pounds': 'Ft-lbs',
    'Calories': 'cal',
    'KiloWatt-Hour': 'kWH',
    'Litre-Atm.': 'L-atm',
  },
  'Area': {
    'Sq. Inches': 'in²',
    'Sq. Feet': 'ft²',
    'Acres': 'acr',
    'Hectares': 'hect',
    'Sq. Miles': 'mil²',
    'Sq. Metres': 'm²',
  },
  'Force': {
    'Newtons': 'N',
    'Dynes': 'dyn',
    'Pounds': 'lbs'
  },
  'Temperature': {
    'Celcius': '°C',
    'Farenheit': '°F',
    'Kelvin': 'K',
    'Reaumer': 'R',

  }
};

class Category {
  IconData outlined;
  IconData filled;
  String category;
  Category(this.category, this.filled, this.outlined, this.categoryIndex);
  int categoryIndex;
}

List<Category> categories = [
  Category('Volume', Icons.water_drop, Icons.water_drop_outlined, 0), // Placeholder icon
  Category('Length', Icons.straighten, Icons.straighten_outlined, 1),
  Category('Mass', Icons.scale, Icons.scale_outlined, 2),
  Category('Time', Icons.timer, Icons.timer_outlined, 3),
  Category('Energy', Icons.flash_on, Icons.flash_on_outlined, 4),
  Category('Area', Icons.grid_view, Icons.grid_view_outlined, 5),
  Category('Force', Icons.work, Icons.work_outlined, 6),
  Category('Temperature', Icons.thermostat, Icons.thermostat_outlined, 7),
];


Map<String, Function> toCelcius = {
  'Celcius': (x) => x,
  'Farenheit': (x) => (x-32)*5/9,
  'Reaumer': (x) => 5*x/4,
  'Kelvin': (x) => x-273.15
};

Map<String, Function> fromCelcius = {
  'Celcius': (x) => x,
  'Farenheit': (x) => x*9/5+32,
  'Reaumer': (x) => 4*x/5,
  'Kelvin': (x) => x + 273.15
};
