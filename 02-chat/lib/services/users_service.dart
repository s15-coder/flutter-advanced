import 'package:chat/global/enviroment.dart';
import 'package:chat/models/users_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:chat/models/user.dart';

class UsersService {
  Future<List<User>> getUsers() async {
    try {
      final resp = await http.get(
        Uri.parse('$host/users'),
        headers: {
          'Authorization': await AuthService.getToken() ?? '',
        },
      );
      final usersResponse = usersResponseFromJson(resp.body);
      return usersResponse.users;
    } catch (e) {
      return [];
    }
  }
}
