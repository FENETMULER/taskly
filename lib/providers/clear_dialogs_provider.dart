import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClearDialogsNotifier extends StateNotifier<bool> {
  ClearDialogsNotifier() : super(false);

  void changeDialogState(bool clear) {
    state = clear;
  }
}

final clearDialogsProvider =
    StateNotifierProvider<ClearDialogsNotifier, bool>((ref) {
  return ClearDialogsNotifier();
});
