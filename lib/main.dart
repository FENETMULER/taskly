import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  App({super.key});

  SMITrigger? _click;

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _click = controller.findInput<bool>('click') as SMITrigger;
  }

  void _triggerClick() => _click!.fire();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          _triggerClick();
        },
        child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), // Shadow color
                  spreadRadius: -18, // Spread radius
                  blurRadius: 6, // Blur radius
                  offset: Offset(0, 5), // Shadow offset
                ),
              ],
            ),
            height: 100,
            width: 100,
            child: RiveAnimation.asset(
              'assets/floating.riv',
              artboard: 'Add Task',
              onInit: _onRiveInit,
            )),
      ),
    ));
  }
}
