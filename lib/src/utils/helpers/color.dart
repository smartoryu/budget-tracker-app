import 'package:flutter/material.dart';

Color getNotionColor(String notion) {
  switch (notion) {
    case 'red':
      return Colors.red;
    case 'green':
      return Colors.green;
    case 'blue':
      return Colors.blue;
    case 'yellow':
      return Colors.yellow;
    case 'orange':
      return Colors.orange;
    case 'purple':
      return Colors.purple;
    case 'pink':
      return Colors.pink;
    case 'brown':
      return Colors.brown;
    case 'grey':
      return Colors.grey;
    case 'black':
      return Colors.black;
    case 'white':
      return Colors.white;
    default:
      return Colors.cyan;
  }
}

Color getCategoryColor(String category) {
  switch (category) {
    case 'Bills':
      return Colors.orange;
    case 'Clothing':
      return Colors.pink;
    case 'Entertainment':
      return Colors.blue;
    case 'Food':
      return Colors.red;
    case 'Health':
      return Colors.purple;
    case 'Shopping':
      return Colors.yellow;
    case 'Transportation':
      return Colors.green;
    case 'Utilities':
      return Colors.grey;
    case 'Other':
    default:
      return Colors.cyan;
  }
}
