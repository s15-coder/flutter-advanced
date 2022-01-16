import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  const BlueButton({Key? key, required this.text, this.onPressed})
      : super(key: key);
  final String text;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              padding:
                  MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10)),

              // backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(StadiumBorder())),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )),
    );
  }
}
