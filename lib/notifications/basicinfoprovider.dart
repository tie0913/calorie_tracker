import 'package:calorie_tracker/db/database.dart';
import 'package:calorie_tracker/dto/basic_info.dart';
import 'package:calorie_tracker/dto/weightlog.dart';
import 'package:flutter/material.dart';

class BasicInfoProvider extends ChangeNotifier {
  BasicInfo? _info;
  bool _hasUserSetInfo = false;

  final List<WeightLog> _weightList = [];

  BasicInfo? get info => _info;
  bool get hasUserSetInfo => _hasUserSetInfo;

  List<WeightLog> get weightList => _weightList;

  BasicInfoProvider() {
    loadFromDb(); 
  }

  Future<void> setBasicInfo(BasicInfo newInfo) async {
    final db = DatabaseHelper.instance;
    await db.saveBasicInfo(newInfo);
    final latest = await db.getLatestBasicInfo();
    _info = BasicInfo.fromMap(latest!);
    _weightList.clear();
    _weightList.addAll(await db.getAllWeights());
    _hasUserSetInfo = true;
    notifyListeners();
  }

  Future<void> clear() async {
    final db = DatabaseHelper.instance;
    await db.clearBasicInfo();
    _info = null;
    _hasUserSetInfo = false;
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
