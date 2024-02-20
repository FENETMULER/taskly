import 'package:flutter/material.dart';

class Task {
  Task({required this.title}) : id = UniqueKey().toString();

  final String id;
  final String title;
}
