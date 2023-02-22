import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app.dart';

class SiftError extends StatelessWidget {
  const SiftError({super.key});

  @override
  Widget build(BuildContext context) => Selector<AppState, String>(
        selector: (_, appState) => appState.siftError,
        builder: (_, error, __) => Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: error.isEmpty ? Colors.transparent : Colors.red.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            error,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
}
