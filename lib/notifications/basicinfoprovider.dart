import 'package:calorie_tracker/db/database.dart';
import 'package:calorie_tracker/dto/basic_info.dart';
import 'package:calorie_tracker/dto/weightlog.dart';
import 'package:flutter/material.dart';

class BasicInfoProvider extends ChangeNotifier {
  BasicInfo? _info;

  List<WeightLog> _weightList = [];

  BasicInfo? get info => _info;

  List<WeightLog> get weightList => _weightList;

  BasicInfoProvider() {
    loadFromDb(); // 启动时自动执行
  }

  Future<void> setBasicInfo(BasicInfo newInfo) async {
    _info = newInfo;

    final db = DatabaseHelper.instance;
    // TODO Nguyen will insert basic info to database

    _weightList.clear();
    _weightList.addAll(await db.getAllWeights());
    notifyListeners();
  }

  Future<void> clear() async {
    final db = DatabaseHelper.instance;
    await db.clearBasicInfo();
    _info = null;
    notifyListeners();
  }

  Future<void> loadFromDb() async {
    final db = DatabaseHelper.instance;

    final result = await db.getLatestBasicInfo();

    if (result != null) {
      _info = BasicInfo.fromMap(result);
    }

    final weightList = await db.getAllWeights();
    if (weightList.isNotEmpty) {
      _weightList.addAll(weightList);
    }

    notifyListeners();
  }
}
