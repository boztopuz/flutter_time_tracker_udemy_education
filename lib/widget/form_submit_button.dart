import 'package:time_tracker_flutter/widget/elevated_button.dart';
import 'package:flutter/material.dart';

class FormSubmitButton extends CustomElevatedButton {
  FormSubmitButton({
    required String text,
    required VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          borderRadius: 4,
          onPressed: onPressed,
          height: 44,
          color: Colors.indigo,
        );
}
