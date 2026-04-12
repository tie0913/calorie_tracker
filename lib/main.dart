import 'package:calorie_tracker/NoStretchScrollBehavior.dart';
import 'package:calorie_tracker/notifications/basicinfoprovider.dart';
import 'package:calorie_tracker/notifications/foodprovider.dart';
import 'package:calorie_tracker/pages/home.dart';
import 'package:calorie_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BasicInfoProvider(),
        ),
        ChangeNotifierProvider(create: (_) => FoodProvider())
      ],
      child: CalorieTrackerApp(),
    ),
  );
}

class CalorieTrackerApp extends StatelessWidget {
  const CalorieTrackerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie Tracker',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      scrollBehavior: NoStretchScrollBehavior(),
      home: const CalorieTrackerPage()
    );
  }
}
