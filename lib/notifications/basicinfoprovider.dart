import 'package:calorie_tracker/db/database.dart';
import 'package:calorie_tracker/dto/basic_info.dart';
import 'package:flutter/material.dart';

class BasicInfoProvider extends ChangeNotifier {
  BasicInfo? _info;

  BasicInfo? get info => _info;

  BasicInfoProvider() {
    loadFromDb(); // 启动时自动执行
  }

  void setBasicInfo(BasicInfo newInfo) {
    _info = newInfo;
    // TODO insert basic info to database
    notifyListeners(); //通知UI更新
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

    notifyListeners();
  }
}
