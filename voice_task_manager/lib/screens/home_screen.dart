import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/database_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis Tareas')),
      body: FutureBuilder<List<Task>>(
        future: DatabaseService().getTasksAtTime(DateTime.now()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task.description),
                subtitle: Text(
                  'Programada: ${task.scheduledTime.toLocal()}',
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add_task');
        },
      ),
    );
  }
}
