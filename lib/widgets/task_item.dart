import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/providers/tasks_provider.dart';
import 'package:taskly/providers/update_provider.dart';

class TaskItem extends ConsumerStatefulWidget {
  const TaskItem({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  ConsumerState<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends ConsumerState<TaskItem> {
  SMIBool? _checkedInput;

  void _checkboxClickHandler() {
    if (!_checkedInput!.value) {
      ref.read(tasksProvider.notifier).toggleChecked(widget.task);
      _checkedInput!.value = true;
    } else {
      ref.read(tasksProvider.notifier).toggleChecked(widget.task);
      _checkedInput!.value = false;
    }
  }

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _checkedInput = controller.findInput<bool>('checked') as SMIBool;
    _checkedInput!.value = widget.task.checked;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        ref.read(tasksProvider.notifier).removeTask(widget.task.id);
      },
      direction: DismissDirection.endToStart,
      background: const Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: SizedBox(
            height: 38,
            width: 38,
            child: RiveAnimation.asset('assets/animations.riv',
                artboard: 'trash',
                animations: ['delete'],
                fit: BoxFit.scaleDown),
          ),
        ),
      ),
      key: ValueKey(widget.task.id),
      child: Container(
        margin: EdgeInsets.only(bottom: 25.0),
        width: 350,
        height: 65,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 8.0), blurRadius: 10.0, color: Colors.grey)
            ]),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              height: 25,
              width: 25,
              color: Colors.white,
              child: GestureDetector(
                onTap: _checkboxClickHandler,
                child: RiveAnimation.asset(
                  'assets/animations.riv',
                  artboard: 'checkbox',
                  onInit: _onRiveInit,
                ),
              ),
            ),
          ),
          Text(
            widget.task.title,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.white),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    ref.read(updateProvider.notifier).enableUpdate(
                        widget.task.id,
                        widget.task.title,
                        _checkedInput!.value);
                  },
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
