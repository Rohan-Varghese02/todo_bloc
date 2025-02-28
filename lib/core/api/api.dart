import 'dart:convert';

import 'package:todo_bloc/data/models/todo_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://api.nstack.in/v1/todos';

Future<bool> addEvent(TodoModel todo) async {
  Map<String, dynamic> todol = {
    'title': todo.title,
    'description': todo.description,
    'is_completed': false,
  };
  final url = 'https://api.nstack.in/v1/todos';
  final uri = Uri.parse(url);
  final response = await http.post(
    uri,
    body: jsonEncode(todol),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 201) {
    print('Event Added ✅');
    print(response.body);

    final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

    if (responseBody.containsKey('data')) {
      final id = responseBody['data']['_id'];
      print('ID: $id');
    }
    return true;
  } else {
    print(response.body);
    return false;
  }
}

Future<List<TodoModel>> intialFetch() async {
  List<TodoModel> todos = [];
  final url = 'https://api.nstack.in/v1/todos?page=1&limit=20';
  final uri = Uri.parse(url);
  final response = await http.get(uri, headers: {'accept': 'application/json'});
  if (response.statusCode == 200) {
    print(response.body);
    final todo = jsonDecode(response.body) as Map<String, dynamic>;
    final todoList = todo['items'] as List;
    for (var item in todoList) {
      final todoItem = TodoModel.fromJsonMap(item as Map<String, dynamic>);
      todos.add(todoItem);
    }
  } else {
    print('Error Fetching');
  }
  return todos;
}

Future<void> deleteTodo(String id) async {
  final uri = Uri.parse('$baseUrl/$id');
  final response = await http.delete(uri);

  if (response.statusCode == 200) {
    print('success');
  }
}

Future<void> editTodo(TodoModel todo) async {
  Map<String, dynamic> body = {
    'title': todo.title,
    'description': todo.description,
    'is_completed': todo.isCompleted,
  };

  final url = '$baseUrl/${todo.id}';
  print(url);
  final uri = Uri.parse(url);
  final response = await http.put(
    uri,
    body: jsonEncode(body),
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode == 200) {
    print('Success');
    print(response.body);
  } else {
    print('Editing Failed');
    print(response.body);
  }
}
