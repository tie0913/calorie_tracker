import 'package:calorie_tracker/notifications/foodprovider.dart';
import 'package:calorie_tracker/pages/homewidgets/cardwrapper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FoodLogWidget extends StatefulWidget {
  const FoodLogWidget({super.key});

  @override
  State<StatefulWidget> createState() => _FoodlogState();
}

class _FoodlogState extends State<FoodLogWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Consumer<FoodProvider>(
      builder: (BuildContext context, FoodProvider provider, Widget? child) {
        final list = provider.list;

        List<Widget> widgets = [
          Text("Today’s Food Log", style: textTheme.titleMedium),
          const SizedBox(height: 12),
        ];
        if (list.isNotEmpty) {
          final it = list.iterator;
          while (it.moveNext()) {
            final log = it.current;
            widgets.add(
              _foodItem(
                context,
                log.name,
                DateFormat('hh:mm a').format(log.logTime),
                "${log.calorie} kcal",
              ),
            );
          }
        } else {
          widgets.add(
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text(
                  "No food logged yet",
                  style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
              ),
            ),
          );
        }

        return CardWrapper.wrap(
          context = context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          ),
        );
      },
    );
    /*
    return CardWrapper.wrap(
      context = context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today’s Food Log", style: textTheme.titleMedium),
          const SizedBox(height: 12),
          _foodItem(context, "Eggs", "9:00 AM", "300 kcal"),
          _foodItem(context, "Chicken Salad", "12:00 PM", "450 kcal"),
          _foodItem(context, "Protein Shake", "2:00 PM", "250 kcal"),
          _foodItem(context, "Steak", "5:00 PM", "400 kcal"),
        ],
      ),
    );*/
  }

  Widget _foodItem(
    BuildContext context,
    String name,
    String time,
    String kcal,
  ) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              const SizedBox(height: 4),
              Text(time, style: theme.textTheme.bodySmall),
            ],
          ),
          Text(kcal),
        ],
      ),
    );
  }
}
