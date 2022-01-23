import 'dart:io';

import 'package:chat/services/auth_service.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  static const routeName = "ChatPage";

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _messageController = TextEditingController();
  final _messageFocus = FocusNode();
  bool _isWriting = false;
  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;
  List<MessageBox> messages = [];
  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);
    _loadMessages(chatService.userTo!.uuid);
    listenMessages();
  }

  void listenMessages() {
    socketService.socket.on("personal-message", (payload) {
      final newMessage = MessageBox(
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 300)),
        message: payload['message'],
        isFromMe: false,
      );
      setState(() {
        messages.insert(0, newMessage);
      });
      newMessage.animationController.forward();
    });
  }

  void _loadMessages(String receiverId) async {
    final messages = await chatService.getMessages(receiverId);
    final chats = messages.map((m) => MessageBox(
          animationController: AnimationController(
            vsync: this,
            duration: Duration(milliseconds: 300),
          )..forward(),
          message: m.message,
          isFromMe: m.from == authService.user!.uuid,
        ));
    this.messages.insertAll(0, chats);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userTo = chatService.userTo;
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              CircleAvatar(
                child: Text(userTo!.name.substring(0, 2)),
              ),
              const SizedBox(width: 10),
              Text(
                userTo.name,
                style: const TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
        body: SizedBox(
          child: SizedBox(
            height: double.maxFinite,
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    reverse: true,
                    itemBuilder: (_, i) => messages[i],
                    itemCount: messages.length,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  height: 60,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          focusNode: _messageFocus,
                          onSubmitted: _handleOnSubmit,
                          textCapitalization: TextCapitalization.sentences,
                          controller: _messageController,
                          decoration: const InputDecoration.collapsed(
                              hintText: "Mensaje"),
                          onChanged: (value) {
                            setState(() {
                              _isWriting = value.trim().isNotEmpty;
                            });
                          },
                        ),
                      ),
                      Container(
                          child: Platform.isIOS
                              ? CupertinoButton(
                                  child: const Text("Enviar"), onPressed: () {})
                              : Container(
                                  margin: const EdgeInsets.all(5),
                                  child: IconTheme(
                                    data:
                                        const IconThemeData(color: Colors.blue),
                                    child: IconButton(
                                      icon: const Icon(Icons.send),
                                      onPressed: _isWriting
                                          ? () => _handleOnSubmit(
                                              _messageController.text)
                                          : null,
                                    ),
                                  ),
                                ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _handleOnSubmit(String value) {
    if (value.isEmpty) return;
    final newMessage = MessageBox(
        message: value,
        animationController: AnimationController(
          duration: Duration(milliseconds: 400),
          vsync: this,
        ),
        isFromMe: true);
    messages.insert(0, newMessage);
    newMessage.animationController.forward();
    _messageController.clear();
    _messageFocus.requestFocus();
    setState(() {
      _isWriting = false;
    });
    socketService.socket.emit('personal-message', {
      "from": authService.user!.uuid,
      "to": chatService.userTo!.uuid,
      "message": value
    });
  }

  @override
  void dispose() {
    for (var message in messages) {
      message.animationController.dispose();
    }
    socketService.socket.off('personal-message');
    super.dispose();
  }
}
