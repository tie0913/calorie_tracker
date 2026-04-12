import 'package:calorie_tracker/dto/basic_info.dart';
import 'package:calorie_tracker/dto/foodlog.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  /// 获取数据库实例（单例）
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('food.db');
    return _database!;
  }

  /// 初始化数据库
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  /// 创建表（只执行一次）
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE basic_info (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER,
        height REAL,
        weight REAL,
        daily_calorie REAL,
        log_time TEXT
      );
    ''');
    await db.execute('''
      INSERT INTO basic_info (
        name,
        age,
        height,
        weight,
        daily_calorie,
        log_time
      ) VALUES (
        'Tie',
        25,
        175,
        80,
        2500,
        '2026-04-11T10:30:00'
      );
    ''');
    await db.execute('''
      CREATE TABLE food_log (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        serve_size REAL,
        calorie REAL,
        protein REAL,
        carbs REAL,
        fats REAL,
        log_time TEXT
      );
    ''');
  }

  Future<void> saveBasicInfo(BasicInfo basicInfo) async {}

  Future<Map<String, dynamic>?> getLatestBasicInfo() async {
    final db = await instance.database;

    final result = await db.query('basic_info', orderBy: 'id DESC', limit: 1);

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<void> appendFoodLog(FoodLog foodLog) async {
    final db = await instance.database;
    await db.insert(
      'food_log',
      foodLog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<FoodLog>> getTodayLogs() async {
    final db = await DatabaseHelper.instance.database;

    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final startOfNextDay = startOfDay.add(const Duration(days: 1));

    final result = await db.query(
      'food_log',
      where: 'log_time >= ? AND log_time < ?',
      whereArgs: [
        startOfDay.toIso8601String(),
        startOfNextDay.toIso8601String(),
      ],
      orderBy: 'log_time DESC', // 👈 倒排
    );

    return result.map((e) => FoodLog.fromMap(e)).toList();
  }

  /// 关闭数据库（一般不用主动调）
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
