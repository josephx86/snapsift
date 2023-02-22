import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:provider/provider.dart';

import '../state/app.dart';
import '../strings.dart';

class Sifter extends StatelessWidget {
  const Sifter({super.key});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          lottie.LottieBuilder.asset(
            'assets/lottie/sift.json',
            width: 300,
            height: 200,
          ),
          const SizedBox(height: 32),
          const Text(S.siftingDuplicates),
          const SizedBox(height: 64),
          SizedBox(
            width: 120,
            child: FilledButton.tonal(
              onPressed: () => _confirmCancel(context),
              child: const Text(
                S.stop,
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      );

  void _confirmCancel(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (cxt) => AlertDialog(
        title: const Text(S.confirm),
        content: const Text(S.confirmStop),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text(S.cancel),
          ),
          TextButton(
            onPressed: () {
              // context.read<AppState>().sifting = false;
              // Navigator.of(context).pop();
            },
            child: const Text(S.yesStop),
          )
        ],
      ),
    );
  }
}
