import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'screens/task_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Parse().initialize(
    'GXgsaTAhgJae5ChgvGe99g5hMgR4Lw9TohVau7Vq',
    'https://parseapi.back4app.com/',
    clientKey: 'NXWqRsQvXiUA3g7my8HBqZeunEDLREFYNHrD8cUd',
    liveQueryUrl: 'wss://GXgsaTAhgJae5ChgvGe99g5hMgR4Lw9TohVau7Vq.b4a.io',
    autoSendSessionId: true,
    debug: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BITS CPAD Flutter Back4App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(),
    );
  }
}
