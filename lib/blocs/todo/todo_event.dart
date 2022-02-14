part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

// FetchApiEvent to call the methods to Fetch the API data
class FetchApiEvent extends TodoEvent {
  // We need the id
  final String id;

  const FetchApiEvent(this.id);

  @override
  List<Object?> get props => [id];
}
