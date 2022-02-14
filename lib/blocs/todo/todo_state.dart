part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {}

// State for when the data is loading
class TodosLoadingState extends TodoState {
  @override
  List<Object> get props => [];
}

// State for when the data is loaded
class TodosLoadedState extends TodoState {
  // We need the result from the API (List<Todos>)
  final List<Todos> result;

  TodosLoadedState(this.result);

  @override
  List<Object?> get props => [result];
}

// State for when the API call resulted in an error
class TodosErrorState extends TodoState {
  // We need the error message
  final String errorMessage;

  TodosErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
