import 'package:calorie_tracker/pages/homewidgets/foodlog.dart';
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
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            WelcomeCard(name: "Tie"),
            //_welcomeCard(context),
            const SizedBox(height: 16),
            _dailyCaloriesCard(context),
            const SizedBox(height: 16),
            _macroCard(context),
            const SizedBox(height: 16),
            _addFoodButton(context),
            const SizedBox(height: 16),
            _simpleCard(context, "Personal info"),
            const SizedBox(height: 16),
            _simpleCard(context, "Weight Progress"),
            const SizedBox(height: 16),
            FoodLog()
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
          )
        ],
      ),
      child: child,
    );
  }

  Widget _dailyCaloriesCard(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return _cardWrapper(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Daily Calories", style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Text("1000 / 2000 kcal"),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.5,
            minHeight: 8,
          ),
          const SizedBox(height: 16),
          _infoBox(context, "Remaining", "450 kcal"),
          const SizedBox(height: 8),
          _infoBox(context, "Consumed", "450 kcal"),
          const SizedBox(height: 8),
          _infoBox(context, "Target", "2000 kcal"),
        ],
      ),
    );
  }

  Widget _infoBox(BuildContext context, String title, String value) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title, style: theme.textTheme.bodySmall),
          const SizedBox(height: 4),
          Text(value, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _macroCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return _cardWrapper(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text("Macro-nutrients", style: textTheme.titleMedium)),
          const SizedBox(height: 16),
          _macroItem(context, "Protein", 0.5),
          const SizedBox(height: 8),
          _macroItem(context, "Carbs", 0.5),
          const SizedBox(height: 8),
          _macroItem(context, "Fats", 0.5),
        ],
      ),
    );
  }

  Widget _macroItem(BuildContext context, String name, double progress) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name),
            Text(
              "1000 / 2000 kcal",
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: progress,
          minHeight: 6,
        ),
      ],
    );
  }

  Widget _addFoodButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text("+ Add Food", style: TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget _simpleCard(BuildContext context, String title) {
    return _cardWrapper(
      context,
      child: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}