import 'package:flutter/material.dart';
import 'package:todo/models/users.dart';
import 'package:todo/views/widgets/home/expanded_tile_child.dart';

class ListItem extends StatefulWidget {
  final Users user;
  const ListItem({Key? key, required this.user}) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    Users user = widget.user;

    // Creating a new theme because the ExpansionTile
    // widget changes the colors of the text when expanded.
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.black,
          onPrimary: Colors.black87,
          secondary: Colors.blue,
          onSecondary: Colors.blueAccent,
          error: Colors.red,
          onError: Colors.redAccent,
          background: Colors.white,
          onBackground: Colors.grey,
          surface: Colors.white,
          onSurface: Colors.white,
        ),
      ),
      child: Card(
        // Make rounded corners on the border
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.grey, width: 2),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              // This lets the tile expand when user taps on it
              ExpansionTile(
                title: Text(
                  user.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: [
                    // Phone icon
                    const Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Icon(
                        Icons.phone,
                        size: 15,
                        color: Colors.blue,
                      ),
                    ),
                    // .split() to remove the extensions
                    Text(user.phone.split('x').first),
                    // Email icon
                    const Padding(
                      padding: EdgeInsets.only(left: 7.0, right: 5.0),
                      child: Icon(
                        Icons.email,
                        size: 15,
                        color: Colors.blue,
                      ),
                    ),
                    // Expanded allows for options when text overflows
                    Expanded(
                      child: Text(
                        user.email,
                        maxLines: 1,
                        // If there is an overflow, use ellipsis at the end of line
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                children: [
                  // This is what is added to the tile when it expands
                  ExpandedTileChild(
                    street: user.address.street,
                    city: user.address.city,
                    zipcode: user.address.zipcode,
                    name: user.name,
                    id: user.id,
                  ),
                ],
                // Arrow icon
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
