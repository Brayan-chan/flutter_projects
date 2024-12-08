import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.description),
      subtitle: Text('Programada: ${task.scheduledTime.toLocal()}'),
    );
  }
}
