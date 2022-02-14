import 'package:todo/constants/constants.dart';
import 'package:todo/models/users.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  // Future<List<Users>> function
  // Calls GET method to pull the list of users from the API
  Future<List<Users>> getUsers() async {
    var res = await http.get(Uri.parse(Constants.api + "/users"));
    if (res.statusCode == 200) {
      List<Users> apiResult = usersFromJson(res.body);
      return apiResult;
    } else {
      throw Exception("Could not fetch list of users");
    }
  }
}
