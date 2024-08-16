// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget 
{
  CustomDropDownButton({super.key, required this.values, required this.selectedValue});
  List<String> values;
  late String selectedValue;

  @override
  Widget build(BuildContext context) 
  {
    return Expanded(
      child: DropdownButton<String>
          (
            style: TextStyle(color: Colors.grey[600]!, fontSize: 14, fontFamily: 'Cairo'),
            // padding: const EdgeInsets.symmetric(horizontal: 16),
            value: selectedValue,
            onChanged: (String? newValue) 
            {
              selectedValue = newValue!;
            },
            items: values
                .map<DropdownMenuItem<String>>((String value) 
                {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
      ),
    );
  }
}