import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/process.dart';
import '../state/app.dart';
import '../strings.dart';
import '../widgets/picker.dart';
import '../widgets/sift_error.dart';
import '../widgets/sifter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: FutureBuilder<bool>(
            future: Future(
              () async => ProcessHelper.hasValidRmlint(),
            ),
            builder: (cxt, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings_sharp, size: 44),
                    SizedBox(height: 32),
                    Text(S.locatingRmlint),
                    SizedBox(height: 16),
                    LinearProgressIndicator(),
                  ],
                );
              } else {
                final hasValidRmlint = snapshot.data ?? false;
                return hasValidRmlint
                    ? Selector<AppState, bool>(
                        selector: (_, appState) => appState.sifting,
                        builder: (_, sifting, __) => sifting
                            ? const Sifter()
                            : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Picker(),
                                  SizedBox(height: 48),
                                  SiftError(),
                                ],
                              ),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline_sharp, size: 44),
                          SizedBox(height: 32),
                          Text(S.failedLocatingRmlint),
                        ],
                      );
              }
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 16,
          color: Theme.of(context).primaryColor,
        ),
      );
}
