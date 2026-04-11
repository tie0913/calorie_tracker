import 'package:calorie_tracker/util/calorie_calculator.dart';

class BasicInfo {
  final int? id;
  final String name;
  final int? age;
  final double? height;
  final double? weight;
  final double? dailyCalorie;
  final String? logTime;

  BasicInfo({
    this.id,
    required this.name,
    this.age,
    this.height,
    this.weight,
    this.dailyCalorie,
    this.logTime,
  });

  /// 从数据库 Map 转对象
  factory BasicInfo.fromMap(Map<String, dynamic> map) {
    return BasicInfo(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      height: map['height'],
      weight: map['weight'],
      dailyCalorie: CalorieCalculator.calculateTDEE(map['weight'] as double, map['height'] as double, map['age'] as int),
      logTime: map['log_time'],
    );
  }

  /// 转 Map（用于插入数据库）
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'height': height,
      'weight': weight,
      'daily_calorie': CalorieCalculator.calculateTDEE(weight!, height!, age!),
      'log_time': logTime,
    };
  }


}