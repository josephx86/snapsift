import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'settings/settings.dart';
import 'snapsift.dart';
import 'state/app.dart';
import 'strings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    setWindowMinSize(Settings.windowMinSize);
    setWindowTitle(S.appName);
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState.getInstance(),
      builder: (_, __) => const SnapSift(),
    ),
  );
}
