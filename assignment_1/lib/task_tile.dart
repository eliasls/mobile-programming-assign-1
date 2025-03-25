import 'package:flutter/material.dart';
import 'task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const TaskTile({super.key, required this.task, this.onDelete, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: Icon(Icons.edit), onPressed: onEdit),
            IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}
