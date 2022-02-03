import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar(
      {Key? key,
      required String label,
      Duration duration = const Duration(seconds: 3),
      String? okButtonText,
      VoidCallback? onOkPressed})
      : super(
            key: key,
            content: Text(label),
            duration: duration,
            action: SnackBarAction(
              label: okButtonText ?? '',
              onPressed: onOkPressed ?? () => {},
            ));
}
