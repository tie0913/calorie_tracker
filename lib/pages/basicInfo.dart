import 'package:calorie_tracker/notifications/basicinfoprovider.dart';
import 'package:calorie_tracker/pages/homewidgets/cardwrapper.dart';
import 'package:calorie_tracker/pages/homewidgets/welcomecard.dart';
import 'package:flutter/material.dart';
import 'package:calorie_tracker/dto/basic_info.dart';
import 'package:calorie_tracker/notifications/basicinfoprovider.dart';
import 'package:provider/provider.dart';

enum HeightUnit { cm, ft }
enum WeightUnit { kg, lb }

class BasicInfoPage extends StatefulWidget {
  const BasicInfoPage({super.key});

  @override
  State<BasicInfoPage> createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends State<BasicInfoPage>{
  bool _isEditMode = false;
  String _name = "Tie";
  int _age = 25;
  double _height = 170.0; // Default height in cm
  double _weight = 70.0; // Default weight in kg

  HeightUnit _heightUnit = HeightUnit.cm;
  WeightUnit _weightUnit = WeightUnit.kg;

  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _ageController = TextEditingController();
  late TextEditingController _heightController;
  late TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _name);
    _ageController = TextEditingController(text: _age.toString());
    _heightController = TextEditingController(text: _height.toString());
    _weightController = TextEditingController(text: _weight.toString());
  }

  String get _displayHeight{
    if (_heightUnit == HeightUnit.cm){
      return _height.toStringAsFixed(0);
    }
    return (_height / 30.48).toStringAsFixed(2); // Convert to feet

  }
  String get _displayWeight{
    if (_weightUnit == WeightUnit.kg){
      return _weight.toStringAsFixed(0);
    }
    return (_weight * 2.20462).toStringAsFixed(1); // Convert to pounds
  }

  void _toggleEditMode() async {
  if (_isEditMode) {
    final heightValue = double.tryParse(_heightController.text);
    final weightValue = double.tryParse(_weightController.text);
    final ageValue = int.tryParse(_ageController.text);

    _name = _nameController.text;

    if (ageValue != null) {
      _age = ageValue;
    }

    if (heightValue != null) {
      _height = _heightUnit == HeightUnit.cm
          ? heightValue
          : heightValue * 30.48;
    }

    if (weightValue != null) {
      _weight = _weightUnit == WeightUnit.kg
          ? weightValue
          : weightValue / 2.20462;
    }

    final newInfo = BasicInfo(
      name: _name,
      age: _age,
      height: _height,
      weight: _weight,
      logTime: DateTime.now().toIso8601String(),
    );
    await context.read<BasicInfoProvider>().setBasicInfo(newInfo);
  }

    setState(() {
      _isEditMode = !_isEditMode;
      _nameController.text = _name;
      _ageController.text = _age.toString();
      _heightController.text = _displayHeight;
      _weightController.text = _displayWeight;
    });
  }

  void _changeHeightUnit(HeightUnit? unit){
    if (unit != null){
      setState(() {
        _heightUnit = unit;
        _heightController.text = _displayHeight;
      });
    }
  }

  void _changeWeightUnit(WeightUnit? unit){
    if (unit != null){
      setState(() {
        _weightUnit = unit;
        _weightController.text = _displayWeight;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic Information"),
        actions: [
          IconButton(
            icon: Icon(_isEditMode ? Icons.check : Icons.edit),
            onPressed: _toggleEditMode,
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            WelcomeCard(),
            const SizedBox(height: 24),
            CardWrapper.wrap(context, 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildField("Name", _nameController),
                  const SizedBox(height: 16),
                  _buildField("Age", _ageController, keyboardType: TextInputType.number),
                  const SizedBox(height: 16),
                  _buildUnitField(
                    label: "Height",
                    controller: _heightController,
                    leftText: "cm",
                    rightText: "ft",
                    leftSelected: _heightUnit == HeightUnit.cm,
                    onLeftTap: () => _changeHeightUnit(HeightUnit.cm),
                    onRightTap: () => _changeHeightUnit(HeightUnit.ft),
                  ),
                  const SizedBox(height: 16),
                  _buildUnitField(
                    label: "Weight",
                    controller: _weightController,
                    leftText: "kg",
                    rightText: "lb",
                    leftSelected: _weightUnit == WeightUnit.kg,
                    onLeftTap: () => _changeWeightUnit(WeightUnit.kg),
                    onRightTap: () => _changeWeightUnit(WeightUnit.lb),
                  ),]
                ,)
              )
          ],
        ),
      ),
    );
  }

    Widget _buildField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          enabled: _isEditMode,
          keyboardType: keyboardType,
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

  Widget _buildUnitField({
    required String label,
    required TextEditingController controller,
    required String leftText,
    required String rightText,
    required bool leftSelected,
    required VoidCallback onLeftTap,
    required VoidCallback onRightTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                enabled: _isEditMode,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
            ),
            const SizedBox(width: 8),
            _buildToggleButton(leftText, leftSelected, onLeftTap),
            const SizedBox(width: 4),
            _buildToggleButton(rightText, !leftSelected, onRightTap),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleButton(
    String text,
    bool selected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 48,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.grey.shade500 : Colors.white,
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(text),
      ),
    );
  }
}
