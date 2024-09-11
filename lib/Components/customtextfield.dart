
import 'package:flutter/material.dart';
import 'package:libphonenumber/libphonenumber.dart';

class CustomTextFormField extends StatelessWidget 
{
  const CustomTextFormField({super.key, required this.hint, this.controller});
  final String? hint;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) 
  {
    bool isValid = true;
    return TextFormField
    (
      controller: controller,
      obscureText: hint == 'كلمة السر' ? true : false,
      keyboardType: 
      hint == 'رقم الهاتف' ? 
        TextInputType.phone 
      : hint == 'البريد الإلكتروني' ? 
        TextInputType.emailAddress 
      : hint == 'السعر' ? 
        const TextInputType.numberWithOptions(decimal: true)
        : TextInputType.name,
      style: TextStyle(color: Colors.blue[900]!),
      validator: (data)
      {
        if(data == null)
        {return 'الحقل مطلوب';}

        if(data.isEmpty)
        {return 'الحقل مطلوب';}

        if(hint == 'رقم الهاتف'  &&!isValid)
        {return 'يرجى إدخال رقم هاتف صحيح مع الرمز الدولي';}

        if(hint == 'السعر')
        {
          final price = num.tryParse(data);
          if (price == null)
          {return 'سعر المنتج يجب أن يكون رقماً';}
        }
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
      onChanged: (value) async
      {
        if(hint == 'رقم الهاتف')
        {
          isValid = await isValidPhoneNumber(value);
        }
      },
    );
  }

  Future<bool> isValidPhoneNumber(String phoneNumber) async 
  {
    try 
    {
      bool? isValid = await PhoneNumberUtil.isValidPhoneNumber
      (
        phoneNumber: phoneNumber,
        isoCode: "",
      );
      return isValid! ;
    } catch (e) 
    {
      return false;
    }
  }
}