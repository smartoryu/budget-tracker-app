import 'package:budget_tracker/src/utils/utils.dart';

class BudgetItem {
  final String id;
  final String name;
  final String category;
  final String categoryColor;
  final String type;
  final String typeColor;
  final double price;
  final bool isGuest;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  BudgetItem({
    required this.id,
    required this.name,
    required this.category,
    required this.categoryColor,
    required this.type,
    required this.typeColor,
    required this.price,
    required this.isGuest,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BudgetItem.fromJson(Map<String, dynamic> json) {
    var _properties = json['properties'];

    return BudgetItem(
      id: json['id'],
      name: NullEscape(_properties?['Name']?['title']?[0]?['plain_text'])
          .withString(),
      category:
          NullEscape(_properties?['Category']?['select']?['name']).withString(),
      categoryColor: NullEscape(_properties?['Category']?['select']?['color'])
          .withString(),
      type: NullEscape(_properties?['Type']?['select']?['name']).withString(),
      typeColor:
          NullEscape(_properties?['Type']?['select']?['color']).withString(),
      price: NullEscape(_properties?['Price']?['number']).withDouble,
      isGuest: NullEscape(_properties?['isGuest']?['checkbox']).withBool,
      date: NullEscape(_properties?['Date']?['date']?['start']).withDate,
      createdAt: NullEscape(json['created_time']).withDate,
      updatedAt: NullEscape(json['last_edited_time']).withDate,
    );
  }
}
