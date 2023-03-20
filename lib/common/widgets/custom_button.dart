import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? handlePress;
  const CustomButton({super.key, this.handlePress});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 40,
      color: Colors.blue.withOpacity(1),
      elevation: 1,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      onPressed: handlePress,
      child: const Text(
        "Save Post",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
