import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget 
{
  const CustomButton({super.key, required this.text, this.onTap});
  final String? text;
  final VoidCallback? onTap;

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