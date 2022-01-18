import 'dart:io';

import 'package:chat/widgets/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  List<MessageBox> messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: const [
              CircleAvatar(
                child: Text("Te"),
              ),
              SizedBox(width: 5),
              Text(
                "Testeando",
                style: TextStyle(color: Colors.black),
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
                  margin: const EdgeInsets.only(left: 15),
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
    print(value);
    if (value.isEmpty) return;
    final newMessage = MessageBox(
      message: value,
      animationController: AnimationController(
        duration: Duration(milliseconds: 400),
        vsync: this,
      ),
      uuid: "123",
    );
    messages.insert(0, newMessage);
    newMessage.animationController.forward();
    _messageController.clear();
    _messageFocus.requestFocus();
    setState(() {
      _isWriting = false;
    });
  }

  @override
  void dispose() {
    for (var message in messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
