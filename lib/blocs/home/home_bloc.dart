import 'package:bloc/bloc.dart';
import 'package:todo/models/users.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/repositories/home_repository.dart';

part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;

  HomeBloc(this._homeRepository) : super(HomeLoadingState()) {
    on<HomeEvent>((event, emit) async {
      // Send loading state to start with
      emit(HomeLoadingState());
      // If our event is FetchApiEvent
      if (event is FetchApiEvent) {
        // Try to call the getUsers method in the HomeRepository
        try {
          final apiRes = await _homeRepository.getUsers();
          // If that worked, send loaded state
          emit(HomeLoadedState(apiRes));
        } catch (e) {
          // If it did not work, send to error state
          emit(HomeErrorState(e.toString()));
        }
      }
    });
  }
}
