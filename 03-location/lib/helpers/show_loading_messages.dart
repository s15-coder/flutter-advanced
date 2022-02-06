import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: const Text('Loading'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('Calculating distance'),
                  SizedBox(height: 5),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        });
  }
  showCupertinoDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: CupertinoAlertDialog(
            title: const Text('Loading'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Calculating distance'),
                SizedBox(height: 5),
                CupertinoActivityIndicator(),
              ],
            ),
          ),
        );
      });
}
