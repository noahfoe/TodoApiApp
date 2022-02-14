import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/repositories/home_repository.dart';
import 'package:todo/repositories/todo_repository.dart';
import 'package:todo/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Wrap with BLoC providers
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HomeRepository>(
          create: (context) => HomeRepository(),
        ),
        RepositoryProvider<TodosRepository>(
          create: (context) => TodosRepository(),
        ),
      ],
      child: MaterialApp(
        // Removes annoying debug banner
        debugShowCheckedModeBanner: false,
        title: 'Lightspeed Voice Interview',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Lightspeed Voice Interview'),
      ),
    );
  }
}
