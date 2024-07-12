import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home: MyHomePage(),));  
}
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() =>  _MyHomePageState(); 
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _todos = ['task1', 'task2', 'task3'];

  void _addTodo(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTodo = '';

        return AlertDialog(
          title: Text("Enter New Task Below: "),
          content: TextField(
            onChanged: (value){
              newTodo = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("Cancle")
            ),
            TextButton(
              onPressed: (){
                setState(() {
                  _todos.add(newTodo);
                });
                Navigator.of(context).pop();
              },
              child: Text("Submit")
            )
          ],
        );
      });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List"), backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index){
          final todo = _todos[index];

          return ListTile(
            title: Text(todo),
            onTap: () {
              setState(() {
                _todos.removeAt(index);
              });
            },
          );
        }),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _addTodo,
          ),
    );
  }
  
}