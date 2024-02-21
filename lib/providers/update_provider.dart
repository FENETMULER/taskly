import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/models/task.dart';

class UpdateState {}

class UpdateNotifier extends StateNotifier<Map<String, dynamic>> {
  UpdateNotifier()
      : super({'update': false, 'id': '', 'title': '', 'checked': false});

  void enableUpdate(String id, String title, bool checked) {
    state = {'update': true, 'id': id, 'title': title, 'checked': checked};
  }

  void disableUpdate() {
    state = {'update': false, 'id': '', 'title': '', 'checked': false};
  }
}

final updateProvider =
    StateNotifierProvider<UpdateNotifier, Map<String, dynamic>>((ref) {
  return UpdateNotifier();
});
