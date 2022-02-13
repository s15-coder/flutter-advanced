import 'package:flutter/material.dart';

Future showLoadingAlert(BuildContext context) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => WillPopScope(
      child: const AlertDialog(
        title: Text('Loading...'),
        content: LinearProgressIndicator(),
      ),
      onWillPop: () async => false,
    ),
  );
}

Future showMessageAlert({
  required BuildContext context,
  required String title,
  required String message,
}) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => WillPopScope(
        child: AlertDialog(
          content: Text(message),
          title: Text(title),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
        onWillPop: () async => true),
  );
}
