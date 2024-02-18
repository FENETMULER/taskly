import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Progress extends StatelessWidget {
  const Progress({super.key});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());
    return Column(children: [
      Text('3 of 9', style: Theme.of(context).textTheme.headlineSmall),
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
          widthFactor: 0.33,
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
