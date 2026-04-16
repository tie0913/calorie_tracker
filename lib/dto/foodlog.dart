class FoodLog {
  final int? id;
  final String name;
  final double? serveSize;
  final double? calorie;
  final double? protein;
  final double? carbs;
  final double? fats;
  final DateTime logTime;

  FoodLog({
    this.id,
    required this.name,
    this.serveSize,
    this.calorie,
    this.protein,
    this.carbs,
    this.fats,
    required this.logTime,
  });

  factory FoodLog.fromMap(Map<String, dynamic> map) {
    return FoodLog(
      id: map['id'],
      name: map['name'],
      serveSize: map['serve_size']?.toDouble(),
      calorie: map['calorie']?.toDouble(),
      protein: map['protein']?.toDouble(),
      carbs: map['carbs']?.toDouble(),
      fats: map['fats']?.toDouble(),
      logTime: DateTime.parse(map['log_time']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'serve_size': serveSize,
      'calorie': calorie,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
      'log_time': logTime.toIso8601String(),
    };
  }

  /// 👉 可选：复制对象（后期很有用）
  FoodLog copyWith({
    int? id,
    String? name,
    double? serveSize,
    double? calorie,
    double? protein,
    double? carbs,
    double? fats,
    DateTime? logTime,
  }) {
    return FoodLog(
      id: id ?? this.id,
      name: name ?? this.name,
      serveSize: serveSize ?? this.serveSize,
      calorie: calorie ?? this.calorie,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
      logTime: logTime ?? this.logTime,
    );
  }
}