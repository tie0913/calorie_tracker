import 'dart:async';
import 'package:calorie_tracker/util/usdaapi.dart';
import 'package:flutter/material.dart';

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({super.key});

  @override
  State<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final _nameController = TextEditingController();
  final _servingController = TextEditingController();
  final _calorieController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatsController = TextEditingController();

  Timer? _debounce;

  Map<String, dynamic>? _cachedFood;
  String _lastFoodName = "";

  // ===============================
  // API 查询（只查一次）
  // ===============================
  Future<void> _loadFood() async {
    final name = _nameController.text;

    if (name.isEmpty) return;

    // 避免重复请求
    if (name == _lastFoodName && _cachedFood != null) return;

    _lastFoodName = name;

    final res = await UsdaApi.searchFood(name);
    if (res == null) return;

    _cachedFood = res;

    _recalculate();
  }

  // ===============================
  // 本地计算（重量变化触发）
  // ===============================
  void _recalculate() {
    if (_cachedFood == null) return;

    final weight = double.tryParse(_servingController.text) ?? 100;
    final factor = weight / 100;

    setState(() {
      _proteinController.text =
          ((_cachedFood!['protein'] ?? 0) * factor).toStringAsFixed(1);

      _calorieController.text =
          ((_cachedFood!['calories'] ?? 0) * factor).toStringAsFixed(0);

      _fatsController.text =
          ((_cachedFood!['fat'] ?? 0) * factor).toStringAsFixed(1);

      _carbsController.text =
          ((_cachedFood!['carbs'] ?? 0) * factor).toStringAsFixed(1);
    });
  }

  // ===============================
  // 输入 food → 防抖调用 API
  // ===============================
  void _onFoodChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _loadFood();
    });
  }

  // ===============================
  // 修改重量 → 本地计算
  // ===============================
  void _onServingChanged(String value) {
    _recalculate();
  }

  // ===============================
  // 提交
  // ===============================
  void _submit() {
    final name = _nameController.text;
    final serving = double.tryParse(_servingController.text) ?? 0;
    final calorie = double.tryParse(_calorieController.text) ?? 0;
    final protein = double.tryParse(_proteinController.text) ?? 0;
    final carbs = double.tryParse(_carbsController.text) ?? 0;
    final fats = double.tryParse(_fatsController.text) ?? 0;

    print("Food: $name");
    print("Serving: $serving");
    print("Calories: $calorie");

    // 👉 下一步：存数据库 + Provider
  }

  @override
  void dispose() {
    _debounce?.cancel();

    _nameController.dispose();
    _servingController.dispose();
    _calorieController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatsController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Food")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildField(
              "Food Name",
              _nameController,
              enabled: true,
              onChanged: _onFoodChanged,
            ),

            const SizedBox(height: 12),

            _buildField(
              "Serving Size (g)",
              _servingController,
              keyboardType: TextInputType.number,
              enabled: true,
              onChanged: _onServingChanged,
            ),

            const SizedBox(height: 12),

            _buildField(
              "Calories (kcal)",
              _calorieController,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 12),

            _buildField(
              "Protein (g)",
              _proteinController,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 12),

            _buildField(
              "Carbs (g)",
              _carbsController,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 12),

            _buildField(
              "Fats (g)",
              _fatsController,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text("Add to Food Log"),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // ===============================
  // 通用输入组件
  // ===============================
  Widget _buildField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    bool enabled = false,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          enabled: enabled,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}