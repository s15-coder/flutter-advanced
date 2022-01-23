import 'package:chat/global/enviroment.dart';
import 'package:chat/models/messages_response.dart';
import 'package:chat/models/user.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  User? userTo;
  Future<List<Message>> getMessages(String receiverId) async {
    try {
      final resp = await http.get(
        Uri.parse('$host/messages/$receiverId'),
        headers: {
          "Authorization": (await AuthService.getToken())!,
        },
      );
      final messagesResponse = messagesResponseFromJson(resp.body);
      return messagesResponse.messages;
    } catch (e) {
      return [];
    }
  }
}
