import 'package:bits_cpad/models/task.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class TaskService {
  static Future<List<Task>> getTasks() async {
    final queryBuilder = QueryBuilder<Task>(Task())..orderByAscending('title');
    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      // Map ParseObjects to Task instances
      List<Task> tasks = response.results!.map((parseObject) {
        return Task.clone()..fromJson(parseObject.toJson());
      }).toList();

      return tasks;
    } else {
      return [];
    }
  }

  static Future<Task?> createTask(String title, String description) async {
    final task = Task()
      ..title = title
      ..description = description;
    final response = await task.save();
    if (response.success) {
      return response.result as Task;
    } else {
      return null;
    }
  }

  static Future<Task?> updateTask(Task task) async {
    final response = await task.save();
    if (response.success) {
      return response.result as Task;
    } else {
      return null;
    }
  }

  static Future<bool> deleteTask(Task task) async {
    final response = await task.delete();
    return response.success;
  }
}
