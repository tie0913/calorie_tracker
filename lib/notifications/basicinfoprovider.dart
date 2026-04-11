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
    notifyListeners(); //通知UI更新
  }

  Future<void> loadFromDb() async {
    final db = DatabaseHelper.instance;

    final result = await db.getLatestBasicInfo();
    
    if(result != null){
      _info = BasicInfo.fromMap(result);
    }

    notifyListeners();
  }

}