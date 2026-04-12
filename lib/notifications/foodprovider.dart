import 'package:calorie_tracker/db/database.dart';
import 'package:calorie_tracker/dto/foodlog.dart';
import 'package:flutter/material.dart';

class FoodProvider extends ChangeNotifier {
  final List<FoodLog> _list = [];

  List<FoodLog> get list => _list;

  FoodProvider() {
    loadFromDb(); // 启动时自动执行
  }

  Future<void> append(FoodLog foodLog) async {
    final db = DatabaseHelper.instance;
    await db.appendFoodLog(foodLog);
    await loadFromDb();
  }

  Future<void> loadFromDb() async {
    final db = DatabaseHelper.instance;
    final result = await db.getTodayLogs();
    _list.clear();
    _list.addAll(result);
    notifyListeners();
  }
}
