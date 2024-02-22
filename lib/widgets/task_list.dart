import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/providers/tasks_provider.dart';
import 'package:taskly/widgets/task_item.dart';

class TaskList extends ConsumerWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    return SizedBox(
      height: 500,
      width: 500,
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) => Align(
          key: ValueKey(tasks[index].id),
          alignment: Alignment.center,
          child: TaskItem(task: tasks[index]),
        ),
      ),
    );
  }
}
