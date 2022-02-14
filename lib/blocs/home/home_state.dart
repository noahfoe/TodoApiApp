part of 'home_bloc.dart';

abstract class HomeState extends Equatable {}

// State for when the data is loading
class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

// State for when the data is loaded
class HomeLoadedState extends HomeState {
  // We need the result from the API (List<Users>)
  final List<Users> result;

  HomeLoadedState(this.result);

  @override
  List<Object?> get props => [result];
}

// State for when the API call resulted in an error
class HomeErrorState extends HomeState {
  // We need the error message
  final String errorMessage;

  HomeErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
