// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget 
{
  CustomTextFormField({super.key, required this.hint});
  String? hint;

  @override
  Widget build(BuildContext context) 
  {
    return TextFormField
    (
      obscureText: hint == 'كلمة السر' ? true : false,
      keyboardType: hint == 'رقم الهاتف' ? TextInputType.phone: TextInputType.name,
      style: TextStyle(color: Colors.grey[600]!),
      validator: (data)
      {
        if(data!.isEmpty)
        {return 'الحقل مطلوب';}
        return null;
      },
      decoration: InputDecoration
      (
        labelText: hint,
        labelStyle: TextStyle(color: Colors.blue[900]!),
        //hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder
        (
          borderSide: BorderSide( color: Colors.blue[900]!)
        ),
        focusedBorder: OutlineInputBorder
        (
          borderSide: BorderSide( color: Colors.orange[700]!)
        ),
        errorBorder: OutlineInputBorder
        (
          borderSide: BorderSide( color: Colors.red[800]!)
        ),
        focusedErrorBorder: OutlineInputBorder
        (
          borderSide: BorderSide( color: Colors.red[800]!)
        ),
      ),
    );
  }
}