  import 'package:flutter/material.dart';

void ShowSnackBar(BuildContext context, String message) 
  {
    ScaffoldMessenger.of(context).showSnackBar
    (
      SnackBar(content: Text(message), duration: const Duration(seconds: 20), showCloseIcon: true,)
    );
  }