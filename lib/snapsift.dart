import 'package:flutter/material.dart';
import 'home.dart';
import 'strings.dart';

class SnapSift extends StatelessWidget {
  const SnapSift({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: S.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
