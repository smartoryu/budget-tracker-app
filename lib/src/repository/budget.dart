import 'dart:convert';

import 'package:budget_tracker/src/models/budget_item.dart';
import 'package:dio/dio.dart';

import '../utils/utils.dart';

class BudgetRepository {
  final Dio _dio;

  BudgetRepository() : _dio = DioClient().create;

  Future<List<BudgetItem>> getItems() async {
    try {
      final response = await _dio.get('/budget_trackers');

      await Future.delayed(const Duration(seconds: 2));

      return (jsonDecode(response.toString())['result']['results'] as List)
          .map((e) => BudgetItem.fromJson(e))
          .toList()
        ..sort(((a, b) => b.date.compareTo(a.date)));
    } on DioError catch (err) {
      throw DioErrorHandler(err);
    }
  }

  Future<BudgetItem> getItemById(String id) async {
    try {
      final response = await _dio.get('/budget_trackers/$id');

      return BudgetItem.fromJson(jsonDecode(response.toString())['result']);
    } on DioError catch (err) {
      throw DioErrorHandler(err);
    }
  }

  void dispose() {
    _dio.close();
  }
}
