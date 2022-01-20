import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/enviroment.dart';
import 'package:chat/models/login_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:chat/models/user.dart';

// Create storage
class AuthService with ChangeNotifier {
  User? user;
  bool _loggingIn = false;
  final _storage = const FlutterSecureStorage();

  set loggingIn(bool value) {
    _loggingIn = value;
    notifyListeners();
  }

  bool get loggingIn => _loggingIn;

  static Future<String?> getToken() {
    const storage = FlutterSecureStorage();
    return storage.read(key: 'token');
  }

  static Future deleteToken() {
    const storage = FlutterSecureStorage();
    return storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    loggingIn = true;
    final body = {
      "email": email,
      "password": password,
    };
    final resp = await http.post(
      Uri.parse("$host/login"),
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    ).timeout(
      const Duration(seconds: 15),
      onTimeout: () => http.Response("", 500),
    );
    loggingIn = false;
    print(resp.body);
    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(json.decode(resp.body));
      user = loginResponse.user;
      saveToken(loginResponse.token);
      return true;
    }
    return false;
  }

  Future<dynamic> register(String name, String email, String password) async {
    loggingIn = true;
    final body = {
      "name": name,
      "email": email,
      "password": password,
    };
    final resp = await http.post(
      Uri.parse("$host/login/new"),
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    ).timeout(
      const Duration(seconds: 15),
      onTimeout: () => http.Response("", 500),
    );
    loggingIn = false;
    print(resp.body);
    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(json.decode(resp.body));
      user = loginResponse.user;
      saveToken(loginResponse.token);
      return true;
    }
    final responseDecoded = jsonDecode(resp.body);
    return responseDecoded;
  }

  Future<bool> verifyToken() async {
    final token = await _storage.read(key: 'token');
    if (token == null) return false;
    final resp = await http.post(
      Uri.parse("$host/login/renew"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token,
      },
    ).timeout(
      const Duration(seconds: 15),
      onTimeout: () => http.Response("", 500),
    );
    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(json.decode(resp.body));
      user = loginResponse.user;
      saveToken(loginResponse.token);
      return true;
    }
    return false;
  }

  Future saveToken(String token) {
    return _storage.write(key: 'token', value: token);
  }
}
