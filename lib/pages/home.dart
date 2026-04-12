import 'package:calorie_tracker/pages/addfood.dart';
import 'package:calorie_tracker/pages/basicInfo.dart';
import 'package:calorie_tracker/pages/homewidgets/dailycaloriecard.dart';
import 'package:calorie_tracker/pages/homewidgets/foodlog.dart';
import 'package:calorie_tracker/pages/homewidgets/micronutri.dart';
import 'package:calorie_tracker/pages/homewidgets/welcomecard.dart';
import 'package:flutter/material.dart';

class CalorieTrackerPage extends StatelessWidget {
  const CalorieTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Calorie Tracker"),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Clear All Data",
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            WelcomeCard(),
            const SizedBox(height: 16),
            DailyCalorieCard(),
            const SizedBox(height: 16),
            MicroNutriWidget(),
            const SizedBox(height: 16),
            _addFoodButton(context),
            const SizedBox(height: 16),
            _simpleButton(
              context,
              "Personal info",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BasicInfoPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _simpleCard(context, "Weight Progress"),
            const SizedBox(height: 16),
            FoodLogWidget(),
          ],
        ),
      ),
    );
  }

  Widget _cardWrapper(BuildContext context, {required Widget child}) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black.withOpacity(
              theme.brightness == Brightness.light ? 0.1 : 0.4,
            ),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _addFoodButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddFoodPage()),
          );
        },
        child: const Text("+ Add Food", style: TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget _simpleCard(BuildContext context, String title) {
    return _cardWrapper(
      context,
      child: Center(
        child: Text(title, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }

  Widget _simpleButton(
    BuildContext context,
    String title, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: _cardWrapper(
        context,
        child: Center(
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
      ),
    );
  }
}
