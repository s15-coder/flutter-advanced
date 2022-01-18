import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final String message;
  final String uuid;
  final AnimationController animationController;
  const MessageBox({
    Key? key,
    required this.message,
    required this.uuid,
    required this.animationController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeIn),
        child: uuid == "123"
            ? _MyMessage(
                message: message,
                animationController: animationController,
              )
            : _NotMyMessage(
                message: message,
                animationController: animationController,
              ),
      ),
    );
  }
}

class _MyMessage extends StatelessWidget {
  final String message;
  final AnimationController animationController;
  const _MyMessage({
    Key? key,
    required this.message,
    required this.animationController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: EdgeInsets.only(
            bottom: 5, right: 5, left: MediaQuery.of(context).size.width * 0.1),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(17),
        ),
      ),
    );
  }
}

class _NotMyMessage extends StatelessWidget {
  final String message;
  final AnimationController animationController;
  const _NotMyMessage({
    Key? key,
    required this.message,
    required this.animationController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: EdgeInsets.only(
            bottom: 5, right: MediaQuery.of(context).size.width * 0.1, left: 5),
        child: Text(message),
        decoration: BoxDecoration(
          color: Colors.yellow[200],
          borderRadius: BorderRadius.circular(17),
        ),
      ),
    );
  }
}
