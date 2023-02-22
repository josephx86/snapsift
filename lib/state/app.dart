import 'package:flutter/material.dart';
import '../models/duplicate_pair.dart';

class AppState extends ChangeNotifier {
  static var rmlintPid = -1;
  static AppState? _instance;
  var _selectedPath = '';
  var _siftError = '';
  var _sifting = false;
  final _duplicates = <DuplicatePair>[];

  static AppState getInstance() {
    _instance ??= AppState._();
    return _instance!;
  }

  AppState._() {
    _instance = this;
  }

  String get siftError => _siftError;
  String get selectedPath => _selectedPath;
  bool get sifting => _sifting;
  List<DuplicatePair> get duplicatePairs => _duplicates;

  set sifting(bool b) {
    if (_sifting != b) {
      _sifting = b;
      notifyListeners();
    }
  }

  set siftError(String s) {
    if (_siftError != s) {
      _siftError = s;
      notifyListeners();
    }
  }

  void reset({String withPath = '', bool clearPairs = true}) {
    _siftError = '';
    _selectedPath = withPath;
    if (clearPairs) {
      clearDuplicates();
    }
    notifyListeners();
  }

  void setDuplicatePairs(Iterable<DuplicatePair> pairs) {
    clearDuplicates();
    _duplicates.addAll(pairs);
  }

  void clearDuplicates() {
    _duplicates.clear();
  }
}
