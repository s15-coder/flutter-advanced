import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  connecting,
  online,
  offline,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  SocketService() {
    _initConfig();
  }

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;

  void _initConfig() {
    _socket = IO.io('http://192.168.1.2:3000/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    _socket.onConnect((_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });
    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });
  }
}
