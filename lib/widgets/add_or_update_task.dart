import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AddOrUpdateTask extends StatelessWidget {
  const AddOrUpdateTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        padding: EdgeInsets.all(20.0),
        height: 180,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            decoration: InputDecoration(
                labelText: 'Enter Title',
                border: OutlineInputBorder(),
                labelStyle: Theme.of(context).textTheme.titleSmall),
          ),
          const SizedBox(height: 30.0),
          SizedBox(
            height: 40,
            width: 150,
            child: RiveAnimation.asset(
              'assets/floating.riv',
              artboard: 'Add Task Button',
            ),
          )
        ]),
      ),
    );
  }
}
