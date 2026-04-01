import 'package:flutter/material.dart';

class CardWrapper {

  static Widget wrap(BuildContext context, {required Widget child}) {
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
}

