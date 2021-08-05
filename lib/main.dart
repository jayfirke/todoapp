import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'To-Do-App', home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  int? Index;
  final List<String> _todoList = <String>[];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey
        ),
          child: ListView(
              children: _getItems()
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(context),
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTodoItem(String title) {
    setState(() {
      _todoList.add(title);
    });
    _textFieldController.clear();
  }

  //Generate list of item widgets
  Widget _buildTodoItem(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,

      ),
      child: ListTile(
        title: Text(title),
        onLongPress: () => {
          Index = _todoList.indexOf(title),
          print(_todoList.indexOf(title)),
          _displayDeleteDialog(context)
        },
      ),
    );
  }

  Future<void> _displayDeleteDialog(BuildContext context) async {
    return showDialog<void> (
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Do you want to delete this'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Delete'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _todoList.removeAt(Index!);
                    });
                  },
                ),
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]
          );
        }
    );
  }

  //Generate a single item widget
  Future<void> _displayDialog(BuildContext context) async {
    return showDialog<void> (
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Add a task to your List'),
              content: TextField(
                controller: _textFieldController,
                decoration: const InputDecoration(hintText: 'Enter task here'),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Add'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _addTodoItem(_textFieldController.text);
                  },
                ),
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]
          );
        }
    );
  }

  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (String title in _todoList) {
      _todoWidgets.add(_buildTodoItem(context, title));
    }
    return _todoWidgets;
  }
}