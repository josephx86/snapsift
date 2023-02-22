import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/filesystem.dart';
import '../helpers/process.dart'; 
import '../strings.dart';
import '../settings/settings.dart';
import '../state/app.dart';

class Picker extends StatelessWidget {
  const Picker({super.key});

  @override
  Widget build(BuildContext context) => Selector<AppState, String>(
        selector: (_, appState) => appState.selectedPath,
        builder: (cxt, selectedPath, __) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              S.setFolder,
              style: TextStyle(fontSize: Settings.largeFontSize),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Theme.of(cxt).primaryColor),
                    ),
                  ),
                  width: 320,
                  child: Row(
                    children: [
                      Expanded(child: Text(selectedPath)),
                      if (selectedPath.isNotEmpty)
                        IconButton(
                          onPressed: cxt.read<AppState>().reset,
                          icon: const Icon(Icons.clear_sharp),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton.tonal(
                  onPressed: () => _pickFolder(cxt),
                  child: const Text(
                    S.pick,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 44),
            SizedBox(
              width: 120,
              child: FilledButton(
                onPressed: selectedPath.isEmpty
                    ? null
                    : () {
                        final appState = cxt.read<AppState>();
                        appState.siftError = '';
                        appState.clearDuplicates();
                        ProcessHelper.sift(
                          appState.selectedPath,
                          Navigator.of(cxt),
                        );
                      },
                child: Text(
                  S.sift.toUpperCase(),
                  style: const TextStyle(
                    fontSize: Settings.largeFontSize,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  void _pickFolder(BuildContext context) async {
    if (FileSystemHelper.isPickingFileSystemItem) {
      showDialog(
        context: context,
        builder: (cxt) => AlertDialog(
          title: const Text(
            S.pickerOpened,
            style: TextStyle(fontSize: Settings.largeFontSize),
          ),
          content: const Text(S.pickerOpenedDetails),
          actions: [
            TextButton(
              onPressed: Navigator.of(cxt).pop,
              child: Text(S.ok.toUpperCase()),
            ),
          ],
        ),
      );
      return;
    }
    final appState = context.read<AppState>();
    final selectedPath = await FileSystemHelper.pickDirectory();
    _setPath(appState, selectedPath);
  }

  void _setPath(AppState appState, String path) {
    appState.reset(withPath: path);
    appState.siftError = '';
    appState.clearDuplicates();
  }
}
