import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/todo/todo_bloc.dart';
import 'package:todo/repositories/todo_repository.dart';
import 'package:todo/views/widgets/states/error_state.dart';
import 'package:todo/views/widgets/states/loading_state.dart';
import 'package:todo/views/widgets/states/todo_loaded_state.dart';

class TodosPage extends StatefulWidget {
  final String name;
  final int id;
  const TodosPage({Key? key, required this.name, required this.id})
      : super(key: key);

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    int id = widget.id;

    return BlocProvider(
      create: (context) => TodoBloc(
        RepositoryProvider.of<TodosRepository>(context),
      )..add(FetchApiEvent(id.toString())),
      child: Scaffold(
        appBar: AppBar(
          title: Text("$name's Todos"),
        ),
        body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
          if (state is TodosLoadingState) {
            return const LoadingState();
          } else if (state is TodosLoadedState) {
            return LoadedState(todosList: state.result);
          } else if (state is TodosErrorState) {
            return ErrorState(error: state.errorMessage);
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
