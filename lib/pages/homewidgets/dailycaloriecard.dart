import 'package:calorie_tracker/notifications/basicinfoprovider.dart';
import 'package:calorie_tracker/notifications/foodprovider.dart';
import 'package:calorie_tracker/pages/homewidgets/cardwrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyCalorieCard extends StatefulWidget {
  const DailyCalorieCard({super.key});
  @override
  State<StatefulWidget> createState() => _DailyCalorieCardState();
}

class _DailyCalorieCardState extends State<DailyCalorieCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FoodProvider>(
      builder: (BuildContext context, FoodProvider provider, Widget? child) {
        final list = provider.list;
        final basicProvider = context.read<BasicInfoProvider>();
        final basic = basicProvider.info;
        int target = basic?.dailyCalorie?.toInt() ?? 0;
        int consumed = 0;
        if (list.isNotEmpty) {
          final it = list.iterator;
          while (it.moveNext()) {
            consumed += it.current.calorie!.toInt();
          }
        }
        int remain = target - consumed;

        double rate = consumed.toDouble() / target;

        final textTheme = Theme.of(context).textTheme;
        return CardWrapper.wrap(
          context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Daily Calories", style: textTheme.titleMedium),
              const SizedBox(height: 8),
              Text("$consumed / $target kcal"),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: rate, minHeight: 8),
              const SizedBox(height: 16),
              _infoBox(context, "Remaining", "$remain kcal"),
              const SizedBox(height: 8),
              _infoBox(context, "Consumed", "$consumed kcal"),
              const SizedBox(height: 8),
              _infoBox(context, "Target", "$target kcal"),
            ],
          ),
        );
      },
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
}
