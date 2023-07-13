import 'package:flutter/material.dart';

class WButton extends StatelessWidget {
  final Function() onPressed;
  final String label;
  final IconData? icon;
  const WButton(
      {required this.onPressed, required this.label, this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon),
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'Aspira',
                    ),
                  )
                ],
              )
            : Text(
                label,
                style: TextStyle(fontFamily: 'Aspira'),
              ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          // backgroundColor: Colors.indigo,
          shape: const StadiumBorder(),
        ));
  }
}
