import 'package:flutter/material.dart';

class ToDo {
  final String title;
  final String description;

  const ToDo(this.title, this.description);
}

List<ToDo> toDoList = [
  ToDo("Paint the house", "Don't forget to use black color"),
  ToDo("Do Plantation", "Don't forget to put some water"),
  ToDo("Go to moon", "Don't forget to use rockets")
];

void main() {
  runApp(MaterialApp(
    title: 'App',
    home: TodosScreen(todos: toDoList),
  ));
}

class TodosScreen extends StatefulWidget {
  final List<ToDo> todos;

  const TodosScreen({Key? key, required this.todos}) : super(key: key);

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Tasks",
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(toDoList[index].title),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(todo: toDoList[index])));
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final ToDo? newToDo = await showDialog(
              context: context,
              builder: (BuildContext context) {
                String? title;
                String? description;

                return AlertDialog(
                  title: const Text("Create New Task"),
                  content: Column(
                    children: <Widget>[
                      TextField(
                        onChanged: (value) {
                          title = value;
                        },
                        decoration: const InputDecoration(labelText: 'Title'),
                      ),
                      TextField(
                        onChanged: (value) {
                          description = value;
                        },
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancle")),
                    TextButton(
                        onPressed: () {
                          if (title != null && description != null) {
                            Navigator.pop(context, ToDo(title!, description!));
                          }
                        },
                        child: Text("Save"))
                  ],
                );
              });
          if (newToDo != null) {
            setState(() {
              toDoList.add(newToDo);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final ToDo todo;

  const DetailScreen({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(todo.description),
      ),
    );
  }
}
