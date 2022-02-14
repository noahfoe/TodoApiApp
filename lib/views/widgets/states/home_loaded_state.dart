import 'package:flutter/material.dart';
import 'package:todo/models/users.dart';
import 'package:todo/views/widgets/home/list_item.dart';

class LoadedState extends StatefulWidget {
  final List<Users> userList;
  const LoadedState({Key? key, required this.userList}) : super(key: key);

  @override
  State<LoadedState> createState() => _LoadedStateState();
}

class _LoadedStateState extends State<LoadedState> {
  @override
  Widget build(BuildContext context) {
    List<Users> userList = widget.userList;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        // Build the list view
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ListItem(user: userList[index]);
          },
          scrollDirection: Axis.vertical,
          itemCount: userList.length,
        ),
      ),
    );
  }
}
