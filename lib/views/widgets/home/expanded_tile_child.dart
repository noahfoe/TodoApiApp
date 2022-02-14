import 'package:flutter/material.dart';
import 'package:todo/views/todos_page.dart';

class ExpandedTileChild extends StatefulWidget {
  final String street;
  final String city;
  final String zipcode;
  final String name;
  final int id;

  const ExpandedTileChild({
    Key? key,
    required this.street,
    required this.city,
    required this.zipcode,
    required this.name,
    required this.id,
  }) : super(key: key);

  @override
  State<ExpandedTileChild> createState() => _ExpandedTileChildState();
}

class _ExpandedTileChildState extends State<ExpandedTileChild> {
  @override
  Widget build(BuildContext context) {
    String street = widget.street;
    String city = widget.city;
    String zipcode = widget.zipcode;
    String name = widget.name;
    int id = widget.id;

    return Column(
      children: [
        Row(
          children: [
            // Location icon
            Padding(
              padding:
                  const EdgeInsets.only(left: 13.0, bottom: 15.0, right: 5),
              child: Column(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.blue,
                    size: 18,
                  ),
                  // Line at bottom of location icon
                  // (I could not find a material icon with the line at the bottom)
                  Container(color: Colors.blue, width: 15, height: 2),
                ],
              ),
            ),
            // Expanded is used to ensure the column takes full space
            Expanded(
              // Location info
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(street),
                  Row(
                    children: [
                      Text(city + ", "),
                      Text(zipcode),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        // Horizontal line after location info and before "View Todos" text
        const Divider(thickness: 2, color: Colors.grey),
        // View Todos row
        GestureDetector(
          onTap: () {
            // Navigate to TodosPage of selected user
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => TodosPage(name: name, id: id)),
              ),
            );
          },
          // View Todos text
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, top: 5.0, right: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "View Todos",
                  style: TextStyle(fontSize: 15),
                ),
                // Long arrow at end of the row
                Icon(Icons.arrow_right_alt_outlined),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
