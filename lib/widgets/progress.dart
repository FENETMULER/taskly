import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:taskly/providers/tasks_provider.dart';

class Progress extends ConsumerWidget {
  Progress({super.key});

  late String statusText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    final totalTasks = tasks.length;
    final checkedTasks = tasks.where((task) => task.checked).length;
    final formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());

    if (totalTasks == 0) {
      statusText = 'No Tasks Yet';
    } else if (checkedTasks == totalTasks) {
      statusText = 'All Tasks Completed!';
    } else {
      statusText = '$checkedTasks of $totalTasks tasks completed';
    }

    return Column(children: [
      Text(statusText,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: totalTasks != 0 && checkedTasks == totalTasks
                  ? Color.fromARGB(255, 63, 81, 240)
                  : null)),
      const SizedBox(height: 5),
      Container(
        width: 400.0,
        height: 20.0,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10.0),
        ),
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: totalTasks == 0 ? 0 : checkedTasks / totalTasks,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
      Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0, right: 55.0),
            child: Text(formattedDate,
                style: Theme.of(context).textTheme.titleSmall),
          )),
    ]);
  }
}
