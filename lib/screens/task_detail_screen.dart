import 'package:flutter/material.dart';
import 'package:bits_cpad/models/task.dart';
import 'package:bits_cpad/screens/edit_task_screen.dart';
import 'package:bits_cpad/services/task_service.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  TaskDetailScreen({required this.task});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  void navigateToEditTaskScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(task: widget.task),
      ),
    );
    if (result != null && result is Task) {
      setState(() {
        widget.task.title = result.title;
        widget.task.description = result.description;
      });
      Navigator.pop(context, widget.task);
    }
  }

  void deleteTask() async {
    final result = await TaskService.deleteTask(widget.task);
    if (result) {
      Navigator.pop(context, widget.task);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to delete task'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              widget.task.title,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              widget.task.description,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('Edit Task'),
                  onPressed: navigateToEditTaskScreen,
                ),
                ElevatedButton(
                  child: Text('Delete Task'),
                  onPressed: deleteTask,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
