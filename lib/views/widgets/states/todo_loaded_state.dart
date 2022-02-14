import 'package:flutter/material.dart';
import 'package:todo/models/todos.dart';
import 'package:todo/repositories/todo_repository.dart';
import 'package:todo/views/widgets/todo/dropdown_menu.dart';

class LoadedState extends StatefulWidget {
  final List<Todos> todosList;
  const LoadedState({Key? key, required this.todosList}) : super(key: key);

  @override
  State<LoadedState> createState() => _LoadedStateState();
}

class _LoadedStateState extends State<LoadedState> {
  late List<Todos> todosList;
  final TodosRepository _todosRepository = TodosRepository();
  late Map<int, bool> completedTodos = {}; // Map {id, completed}
  late int completed = 0;

  @override
  void initState() {
    super.initState();
    todosList = widget.todosList;

    // Loop to add completed todos to new list
    for (var element in todosList) {
      if (element.completed == true) {
        completedTodos.addAll({element.id: element.completed});
        completed += 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Dropdown used to sort by A-Z or by ID
              DropdownMenu(
                sortById: _sortById,
                sortAlphabetically: _sortAlphabetically,
              ),
              Text(
                  "${completed.toString()}/${todosList.length} Todo's Completed"),
            ],
          ),
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(
                  color: Colors.black, style: BorderStyle.solid, width: 1),
            ),
            // Build the list view
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        // This causes the checkbox to be on the left
                        // instead of the right
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Flexible allows text to wrap to next line
                            // instead of overflowing
                            Flexible(
                              child: Text(
                                todosList[index].title,
                                style: TextStyle(
                                  // Strikethrough text if it is completed
                                  decoration: completedTodos
                                          .containsKey(todosList[index].id)
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ),
                            // Delete Todo
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  // If todo is completed, decrement # of completed
                                  if (completedTodos
                                      .containsKey(todosList[index].id)) {
                                    completed -= 1;
                                  }
                                  // Delete the Todo it from the API (fake delete)
                                  _todosRepository.deleteTodo(
                                      todosList[index].id.toString());
                                  // Delete a Todo from the current list
                                  todosList.removeAt(index);
                                });
                              },
                              child:
                                  const Icon(Icons.delete, color: Colors.grey),
                            ),
                          ],
                        ),
                        // Update Checkbox
                        onChanged: (bool? value) {
                          setState(() {
                            // If completedTodos has the id, then it WAS checked,
                            // and needs to be removed, and vice versa.
                            if (completedTodos
                                .containsKey(todosList[index].id)) {
                              completedTodos.remove(todosList[index].id);
                              // Since we are removing the checkbox
                              completed -= 1;
                            } else {
                              completedTodos
                                  .addAll({todosList[index].id: true});
                              completed += 1;
                            }
                            _todosRepository.updateTodo(
                                todosList[index].id.toString(), value!);
                          });
                        },
                        value: completedTodos.containsKey(todosList[index].id)
                            ? true
                            : false,
                      ),
                      // Black line at the bottom of each Todo.
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Divider(
                          color: Colors.black,
                          thickness: 1,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                );
              },
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: todosList.length,
            ),
          ),
        ],
      ),
    );
  }

  // Void function that sorts the list alphabetically
  void _sortAlphabetically() {
    setState(() {
      todosList.sort(((a, b) => a.title.compareTo(b.title)));
    });
  }

  // Void function that sorts the list by ID
  void _sortById() {
    setState(() {
      todosList.sort(((a, b) => a.id.compareTo(b.id)));
    });
  }
}
