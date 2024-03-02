import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/providers/tasks_provider.dart';

class Progress extends ConsumerWidget {
  Progress({super.key});

  late String _statusText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final tasks = ref.watch(tasksProvider);
    final totalTasks = tasks.length;
    final checkedTasks = tasks.where((task) => task.checked).length;
    final formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());

    if (totalTasks == 0) {
      _statusText = 'No Tasks Yet';
    } else if (checkedTasks == totalTasks) {
      _statusText = 'All Tasks Completed!';
    } else {
      _statusText = '$checkedTasks of $totalTasks tasks completed';
    }

    return Column(children: [
      Text(_statusText,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: totalTasks != 0 && checkedTasks == totalTasks
                  ? const Color.fromARGB(255, 63, 81, 240)
                  : null)),
      const SizedBox(height: 5),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: width < 425 ? 10 : 0),
        child: Container(
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
      ),
      Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, left: width < 425 ? 0 : 300),
            child: Text(formattedDate,
                style: Theme.of(context).textTheme.titleSmall),
          )),
    ]);
  }
}
