

import 'package:flutter/material.dart';

class FoodLog extends StatefulWidget{
  const FoodLog({super.key});

  @override
  State<StatefulWidget> createState() => _FoodlogState();
}

class _FoodlogState extends State<FoodLog> {


  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

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
    );
  }


  Widget _foodItem(
      BuildContext context, String name, String time, String kcal) {
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