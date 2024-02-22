import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/providers/clear_dialogs_provider.dart';

import 'package:taskly/providers/update_provider.dart';

import 'package:taskly/widgets/add_or_update_task.dart';
import 'package:taskly/widgets/progress.dart';

import 'package:taskly/widgets/task_list.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  SMIBool? _active;

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _active = controller.findInput<bool>('active') as SMIBool;
  }

  var _showNewTaskDialog = false;

  void _clearDialog() {
    setState(() {
      _showNewTaskDialog = false;
    });
    _deactivateActionButton();
  }

  void _activateActionButton() {
    _active!.value = true;
  }

  void _deactivateActionButton() {
    _active!.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final updateState = ref.watch(updateProvider);
    final clearDialogs = ref.watch(clearDialogsProvider);
    if (clearDialogs) {
      _clearDialog();
    }
    if (updateState['update']) {
      _activateActionButton();
    }
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15.0),
                Text(
                  'Taskly.',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 28.0),
                Progress(),
                const SizedBox(height: 15.0),
                TaskList()
              ],
            ),
          ),
          if (_showNewTaskDialog)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 200.0),
                child: AddOrUpdateTask(),
              ),
            ),
          if (updateState['update'])
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 200.0),
                child: AddOrUpdateTask(
                  taskId: updateState['id'],
                  taskTitle: updateState['title'],
                  checked: updateState['checked'],
                ),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          setState(() {
            _showNewTaskDialog = !_showNewTaskDialog;

            if (_showNewTaskDialog) {
              ref.read(clearDialogsProvider.notifier).changeDialogState(false);
              _activateActionButton();
            } else {
              _deactivateActionButton();
            }
            if (updateState['update']) {
              ref.read(updateProvider.notifier).disableUpdate();
              _clearDialog();
            }
          });
        },
        child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), // Shadow color
                  spreadRadius: -18, // Spread radius
                  blurRadius: 6, // Blur radius
                  offset: const Offset(0, 5), // Shadow offset
                ),
              ],
            ),
            height: 100,
            width: 100,
            child: RiveAnimation.asset(
              'assets/animations.riv',
              artboard: 'Add Task',
              onInit: _onRiveInit,
            )),
      ),
    );
  }
}
