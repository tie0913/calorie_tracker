
import 'package:calorie_tracker/pages/homewidgets/cardwrapper.dart';
import 'package:flutter/material.dart';

class WelcomeCard extends StatefulWidget {
  final String name;

  const WelcomeCard({
    super.key,
    required this.name,
  });

  @override
  State<WelcomeCard> createState() => _WelcomeCardState();
}

class _WelcomeCardState extends State<WelcomeCard> {
  bool _expanded = false;

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: _toggle,
      child: CardWrapper.wrap(context, 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome, ${widget.name}!",
                style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              _expanded
                  ? "You’re doing great today 💪"
                  : "Track your nutrition all right",
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}