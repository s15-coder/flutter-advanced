import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showCustomAlert(BuildContext context, String title, String description) {
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(description),
              actions: [
                MaterialButton(
                  child: const Text('Ok'),
                  elevation: 5,
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ));
  }
  return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(description),
            actions: [
              CupertinoButton(
                child: const Text('Ok'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ));
}
