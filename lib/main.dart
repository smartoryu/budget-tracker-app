import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:budget_tracker/src/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Tracker w/ Notion',
      theme: FlexThemeData.light(scheme: FlexScheme.shark),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.shark),
      home: const DashboardScreen(),
    );
  }
}
