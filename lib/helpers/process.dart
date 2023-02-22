import 'dart:io';

import 'package:flutter/material.dart';

import '../models/duplicate_pair.dart';
import '../screens/results.dart';
import '../state/app.dart';
import '../strings.dart';

class ProcessHelper {
  static const _rmlintName = 'rmlint';

  static bool hasValidRmlint() {
    var isValid = false;
    try {
      const version = 'version';
      final process = Process.runSync(
        _rmlintName,
        ['--$version'],
      );

      final stdoutResult = process.stdout as String? ?? '';
      final stderrResult = process.stderr as String? ?? '';
      isValid = stdoutResult.toLowerCase().contains(version) ||
          stderrResult.toLowerCase().contains(version);
    } on Exception {
      // Ignore
    }
    return isValid;
  }

  static void sift(String dir, NavigatorState navigator) {
    try {
      var result = '';
      var error = '';
      Process.start(
        _rmlintName,
        ['-o', 'fdupes:stdout', dir],
        workingDirectory: dir,
      ).then(
        (process) {
          AppState.rmlintPid = process.pid;
          final buffer = <int>[];
          Future(() async {
            await process.stdout.forEach((bytes) {
              buffer.addAll(bytes);
            });
            final errorBuffer = <int>[];
            await process.stderr.forEach((bytes) {
              errorBuffer.addAll(bytes);
            });
            result = String.fromCharCodes(buffer);
            error = String.fromCharCodes(errorBuffer);

            final lines = result.split('\n');
            var left = '';
            var right = '';
            final duplicates = <DuplicatePair>[];
            for (final l in lines) {
              final current = l.trim();
              if (current.isEmpty) {
                continue;
              }

              if (left.isEmpty) {
                left = current;
              } else if (right.isEmpty) {
                right = current;
              }

              if (left.isNotEmpty && right.isNotEmpty) {
                final pair = DuplicatePair(left, right);
                duplicates.add(pair);
                left = '';
                right = '';
              }
            }
            AppState.rmlintPid = -1;
            error = error.trim();
            final appState = AppState.getInstance();
            if (error.isEmpty) {
              appState.setDuplicatePairs(duplicates);
              navigator.push(
                MaterialPageRoute(builder: (_) => const ResultsScreen()),
              );
              appState.reset(clearPairs: false);
            } else {
              appState.siftError = error;
              appState.clearDuplicates();
            }
          });
        },
      );
    } on Exception {
      final appState = AppState.getInstance();
      appState.siftError = S.unknownError;
      appState.clearDuplicates();
    }
  }
}
