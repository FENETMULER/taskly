import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/providers/clear_dialogs_provider.dart';

import 'package:taskly/providers/tasks_provider.dart';
import 'package:taskly/providers/update_provider.dart';

class AddOrUpdateTask extends ConsumerWidget {
  AddOrUpdateTask({super.key, this.taskId, this.taskTitle, this.checked});

  String? taskId;
  String? taskTitle;
  bool? checked;

  SMITrigger? _click;

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _click = controller.findInput<bool>('click') as SMITrigger;
  }

  void _triggerClick() {
    _click!.fire();
  }

  final TextEditingController _taskTextFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (taskId != null) {
      _taskTextFieldController.text = taskTitle!;
    }
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        height: 170,
        width: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 8.0),
                  blurRadius: 15.0,
                  color: Color.fromARGB(255, 180, 180, 180))
            ]),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            controller: _taskTextFieldController,
            decoration: InputDecoration(
                labelText: 'Enter Task',
                border: const OutlineInputBorder(),
                labelStyle: Theme.of(context).textTheme.titleSmall),
          ),
          const SizedBox(height: 15.0),
          GestureDetector(
            onTap: () {
              if (_taskTextFieldController.text.isNotEmpty) {
                if (taskId == null) {
                  ref
                      .read(tasksProvider.notifier)
                      .addNewTask(_taskTextFieldController.text);
                } else {
                  ref.read(tasksProvider.notifier).updateTask(
                      taskId!, _taskTextFieldController.text, checked!);
                  ref.read(updateProvider.notifier).enableUpdate(
                      taskId!, _taskTextFieldController.text, checked!);
                }
                // ref.read(updateProvider.notifier).disableUpdate();
                Future.delayed(const Duration(seconds: 1), () {
                  ref
                      .read(clearDialogsProvider.notifier)
                      .changeDialogState(true);
                });
                _triggerClick();
              }
            },
            child: SizedBox(
              height: 60,
              width: 180,
              child: RiveAnimation.asset('assets/animations.riv',
                  artboard:
                      taskId == null ? 'Add Task Button' : 'Update Task Button',
                  onInit: _onRiveInit,
                  fit: BoxFit.cover),
            ),
          )
        ]),
      ),
    );
  }
}
