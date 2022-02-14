import 'package:flutter/material.dart';

class DropdownMenu extends StatefulWidget {
  final Function sortById;
  final Function sortAlphabetically;
  const DropdownMenu(
      {Key? key, required this.sortById, required this.sortAlphabetically})
      : super(key: key);

  @override
  State<DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  String dropdownValue = 'ID';

  @override
  Widget build(BuildContext context) {
    Function idCallback = widget.sortById;
    Function alphaCallback = widget.sortAlphabetically;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: 100,
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      "Sort By",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down_outlined),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      if (dropdownValue == 'ID') {
                        idCallback();
                      } else {
                        alphaCallback();
                      }
                    });
                  },
                  items: <String>['ID', 'A-Z']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
