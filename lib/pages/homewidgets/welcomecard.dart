
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
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
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
            Text("Welcome, ${widget.name}!",
                style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              _expanded
                  ? "You’re doing great today 💪"
                  : "Track your nutrition",
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}