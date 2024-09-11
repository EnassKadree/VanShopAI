// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget 
{
  CustomButton({super.key, required this.text, this.onTap});
  String? text;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) 
  {
    return InkWell
    (
      onTap: onTap,
      child: Container
      (
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration
        (
          color: Colors.orange[700]!,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center
        (
          child: Text
          (
            '$text',
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}