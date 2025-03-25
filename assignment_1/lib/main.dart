// lib/main.dart
import 'package:flutter/material.dart';
import '/task.dart';
import '/task_tile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Dette er hovedwidgeten som starter appen
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = [];
  final TextEditingController _controller = TextEditingController();

  // Opprett (Create): Legger til en ny oppgave
  void _addTask(String title) {
    if (title.trim().isEmpty) return;
    setState(() {
      tasks.add(Task(id: DateTime.now().toString(), title: title));
    });
    _controller.clear();
  }

  // Rediger (Update): Åpner en dialog for å redigere en oppgave
  void _editTask(Task task) {
    final TextEditingController editController = TextEditingController(
      text: task.title,
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rediger oppgave'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(labelText: 'Oppgave'),
          ),
          actions: [
            TextButton(
              child: Text('Avbryt'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Lagre'),
              onPressed: () {
                setState(() {
                  task.title = editController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Slett (Delete): Fjerner en oppgave fra listen
  void _deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do Liste')),
      body: Column(
        children: [
          // Inputfelt og knapp for å legge til nye oppgaver
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Ny oppgave'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addTask(_controller.text);
                  },
                  child: Text('Legg til'),
                ),
              ],
            ),
          ),
          // Viser listen over oppgaver
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskTile(
                  task: task,
                  onEdit: () => _editTask(task),
                  onDelete: () => _deleteTask(task),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
