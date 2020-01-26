
import 'package:flutter/material.dart';
import 'todo.dart';


class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> todos = [];
TextEditingController controller = new TextEditingController();
  _toggleTodo(Todo todo, bool isChecked) {
    setState(() {
      todo.isDone = isChecked;
    });
  }

  Widget _buildItem(BuildContext context, int index) {
    final todo = todos[index];
    return CheckboxListTile(
      value: todo.isDone,
      title: Text(todo.title),
      onChanged: (bool isChecked) {
        _toggleTodo(todo, isChecked);
      },
    );
  }

    _addTodo() async {
     final todo = await showDialog<Todo>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          title: Text('Create checkbox'),
          content: TextField(
            controller: controller,
            autofocus: true,
          ),
          actions: <Widget>[
            FlatButton(
              padding: EdgeInsets.only(right: 120.0),
              child: Text('Cancel',style: TextStyle(fontSize: 20.0),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              
              child: Text('Add',style: TextStyle(fontSize: 20.0),),
              onPressed: () {
               
                setState(() {
                  final todo = new Todo(title: controller.value.text);
                 
                  if(controller.value.text == ""){
                    print(" ");
                  }else{
                    todos.add(todo);
                  }
                Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
    if (todo != null) {
       setState(() {
         todos.add(todo);
       });
     }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: ListView.builder(
        itemBuilder: _buildItem,
        itemCount: todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTodo,
      ),
    );
  }
}