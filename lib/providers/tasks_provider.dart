import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/models/task.dart';

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([]);

  void addNewTask(String taskName) {
    state = [...state, Task(id: UniqueKey().toString(), title: taskName)];
  }

  void removeTask(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void updateTask(String id, String newName) {
    state = state.map((task) {
      if (task.id == id) {
        return Task(id: task.id, title: newName);
      } else {
        return task;
      }
    }).toList();
  }
}

final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});
