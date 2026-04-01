
import 'package:calorie_tracker/pages/homewidgets/cardwrapper.dart';
import 'package:flutter/material.dart';

class DailyCalorieCard extends StatefulWidget{
  const DailyCalorieCard({super.key});
  @override
  State<StatefulWidget> createState() => _DailyCalorieCardState();
}

class _DailyCalorieCardState extends State<DailyCalorieCard> {
  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    return CardWrapper.wrap(context, child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Daily Calories", style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Text("800 / 2000 kcal"),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.4,
            minHeight: 8,
          ),
          const SizedBox(height: 16),
          _infoBox(context, "Remaining", "450 kcal"),
          const SizedBox(height: 8),
          _infoBox(context, "Consumed", "450 kcal"),
          const SizedBox(height: 8),
          _infoBox(context, "Target", "2000 kcal"),
        ],
      ));
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
  
}