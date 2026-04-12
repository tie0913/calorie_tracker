import 'package:calorie_tracker/notifications/basicinfoprovider.dart';
import 'package:calorie_tracker/notifications/foodprovider.dart';
import 'package:calorie_tracker/pages/homewidgets/cardwrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MicroNutriWidget extends StatelessWidget {
  const MicroNutriWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FoodProvider>(
      builder:
          (BuildContext context, FoodProvider foodProvider, Widget? child) {
            final textTheme = Theme.of(context).textTheme;

            final list = foodProvider.list;
            final basic = context.read<BasicInfoProvider>().info;

            double totalTarget = basic?.dailyCalorie ?? 0;

            double proteinConsumed = 0;
            double carbsConsumed = 0;
            double fatsConsumed = 0;

            double proteinTarget = totalTarget * 0.3 * 0.25;
            double carbsTarget = totalTarget * 0.4 * 0.25;
            double fatsTarget = totalTarget * 0.3 * 0.11;

            if (list.isNotEmpty) {
              final it = list.iterator;
              while (it.moveNext()) {
                final cur = it.current;
                proteinConsumed += cur.protein ?? 0;
                carbsConsumed += cur.carbs ?? 0;
                fatsConsumed += cur.fats ?? 0;
              }
            }

            return CardWrapper.wrap(
              context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Macro-nutrients",
                      style: textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _macroItem(context, "Protein", proteinTarget, proteinConsumed),
                  const SizedBox(height: 8),
                  _macroItem(context, "Carbs", carbsTarget, carbsConsumed),
                  const SizedBox(height: 8),
                  _macroItem(context, "Fats", fatsTarget, fatsConsumed),
                ],
              ),
            );
          },
    );
  }

  Widget _macroItem(
    BuildContext context,
    String name,
    double target,
    double consumed,
  ) {
    final theme = Theme.of(context);

    double progress = consumed / target;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name),
            Text("${consumed.toInt()} / ${target.toInt()} g", style: theme.textTheme.bodySmall),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(value: progress, minHeight: 6),
      ],
    );
  }
}
