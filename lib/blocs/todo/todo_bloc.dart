import 'package:bloc/bloc.dart';
import 'package:todo/models/todos.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/repositories/todo_repository.dart';

part 'todo_state.dart';
part 'todo_event.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodosRepository _todosRepository;

  TodoBloc(this._todosRepository) : super(TodosLoadingState()) {
    on<TodoEvent>((event, emit) async {
      // Send loading state to start with
      emit(TodosLoadingState());
      // If our event is FetchApiEvent
      if (event is FetchApiEvent) {
        // Try to call the getTodos method in the TodosRepository
        try {
          final apiRes = await _todosRepository.getTodos(event.id);
          // If that worked, send loaded state
          emit(TodosLoadedState(apiRes));
        } catch (e) {
          // If it did not work, send error state
          emit(TodosErrorState(e.toString()));
        }
      }
    });
  }
}
