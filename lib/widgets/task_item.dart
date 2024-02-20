import 'package:flutter/material.dart';
import 'package:taskly/models/task.dart';
import 'package:rive/rive.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.task});
  final Task task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: SizedBox(
            height: 45,
            width: 45,
            child: RiveAnimation.asset('assets/floating.riv',
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(height: 25, width: 25, color: Colors.white),
          ),
          Text(widget.task.title,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white, decoration: TextDecoration.lineThrough)),
        ]),
      ),
    );
  }
}
