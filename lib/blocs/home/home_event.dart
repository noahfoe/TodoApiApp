part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

// FetchApiEvent to call the methods to Fetch the API data
class FetchApiEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}
