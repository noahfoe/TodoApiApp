import 'dart:convert';

import 'package:todo/constants/constants.dart';
import 'package:todo/models/todos.dart';
import 'package:http/http.dart' as http;

class TodosRepository {
  // Future<List<Todos>> function that takes a string of the userId as a parameter
  // Calls GET method to pull the list of Todos from the API
  Future<List<Todos>> getTodos(String id) async {
    var res = await http.get(Uri.parse(Constants.api + "/todos?userId=" + id));
    if (res.statusCode == 200) {
      List<Todos> apiResult = todosFromJson(res.body);
      return apiResult;
    } else {
      throw Exception("Could not fetch list of todos");
    }
  }

  // Future<void> funcion that takes a string of the id (of the Todo, not the user)
  // Calls DELETE method to "delete" a Todo from the API
  Future<void> deleteTodo(String id) async {
    var res = await http.delete(Uri.parse(Constants.api + "/todos/" + id));
    if (res.statusCode != 200) {
      throw Exception("Could not delete todo with id=" + id);
    }
  }

  // Future<void> function take takes a string of the id (of the Todo again),
  // as well a boolean of wether or not that todo is completed or not.
  // Calls PATCH method to update the todos completed element.
  Future<void> updateTodo(String id, bool completed) async {
    var body = json.encode({"completed": completed});
    var res = await http.patch(
      Uri.parse(Constants.api + "/todos/" + id),
      body: body,
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
    );
    if (res.statusCode != 200) {
      throw Exception("Could not update todo with id=" + id);
    }
  }
}
