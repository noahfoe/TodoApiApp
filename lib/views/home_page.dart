import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/home/home_bloc.dart';
import 'package:todo/repositories/home_repository.dart';
import 'package:todo/views/widgets/states/error_state.dart';
import 'package:todo/views/widgets/states/home_loaded_state.dart';
import 'package:todo/views/widgets/states/loading_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeRepository apiService = HomeRepository();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        RepositoryProvider.of<HomeRepository>(context),
      )..add(FetchApiEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Users"),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const LoadingState();
            } else if (state is HomeLoadedState) {
              return LoadedState(userList: state.result);
            } else if (state is HomeErrorState) {
              return ErrorState(error: state.errorMessage);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
