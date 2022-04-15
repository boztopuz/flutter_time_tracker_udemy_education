import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/widget/elevated_button.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton(
      {required String text,
      required Color color,
      required Color textColor,
      required VoidCallback onPressed,
      required double borderRadius,
      required double height,
      })
      : super(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 15,
            ),
          ),
          color: color,
          borderRadius: borderRadius,
          onPressed: onPressed,
          height: height,
        );
}
