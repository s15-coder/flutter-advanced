import 'package:band_names/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          socketService.socket.emit(
            "new-message",
            {"name": "esteban", "lastname": "barragan,"},
          );
        },
        child: const Icon(Icons.message),
      ),
      body: Center(
        child: Text("Status Page: ${socketService.serverStatus}"),
      ),
    );
  }
}
