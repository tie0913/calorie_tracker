import 'package:calorie_tracker/notifications/basicinfoprovider.dart';
import 'package:calorie_tracker/pages/homewidgets/cardwrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeCard extends StatefulWidget {
  const WelcomeCard({super.key});

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

    return Consumer<BasicInfoProvider>(
      builder: (context, provider, child) {
        final info = provider.info;
        return GestureDetector(
          onTap: _toggle,
          child: CardWrapper.wrap(
            context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info != null ? "Welcome, ${info.name}!" : "Welcome",
                  style: theme.textTheme.titleMedium,
                ),
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
      },
    );
  }
}
