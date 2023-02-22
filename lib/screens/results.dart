import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/duplicate_pair.dart';
import '../state/app.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppState>();
    final results = appState.duplicatePairs;
    print(results);
    return Scaffold(body: BackButton(),);
  }
}
