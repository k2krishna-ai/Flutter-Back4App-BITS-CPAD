import 'package:flutter/material.dart';
import 'package:bits_cpad/models/task.dart';
import 'package:bits_cpad/screens/add_task_screen.dart';
import 'package:bits_cpad/screens/task_detail_screen.dart';
import 'package:bits_cpad/services/task_service.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  void fetchTasks() async {
    final result = await TaskService.getTasks();
    setState(() {
      tasks = result;
    });
  }

  void navigateToAddTaskScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskScreen()),
    );
    if (result != null && result is Task) {
      setState(() {
        tasks.add(result);
      });
    }
  }

  void navigateToTaskDetailScreen(Task task) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskDetailScreen(task: task)),
    );
    if (result != null && result is Task) {
      setState(() {
        tasks.remove(task);
        tasks.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BITS CPAD Flutter Back4App'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
            onTap: () => navigateToTaskDetailScreen(task),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: navigateToAddTaskScreen,
      ),
    );
  }
}
