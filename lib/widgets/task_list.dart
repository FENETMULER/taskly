import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/providers/tasks_provider.dart';
import 'package:taskly/widgets/task_item.dart';

class TaskList extends ConsumerWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    final remainingSpace = MediaQuery.of(context).size.height -
        192; // 140 is the total height of the widgets above task list
    return SizedBox(
      height: remainingSpace,
      width: 500,
      child: tasks.isEmpty
          ? Padding(
              padding: EdgeInsets.only(bottom: remainingSpace / 2),
              child: Center(
                child: Text('Add a task to get started',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: const Color.fromARGB(255, 158, 158, 158))),
              ),
            )
          : ListView.builder(
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
