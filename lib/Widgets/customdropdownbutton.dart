// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Auth/Signup%20Cubit/sign_up_cubit.dart';

class CustomDropDownButton extends StatelessWidget 
{
  CustomDropDownButton({super.key, required this.values, required this.selectedValue, required this.hint});
  List<String> values;
  late String? selectedValue;
  String hint;

  @override
  Widget build(BuildContext context) 
  {
    return Row(
      children: 
      [
        Expanded
        (
          
          child: DropdownButton<String>
          (
            hint: Text(hint),
            style: TextStyle(color: Colors.blue[900]!, fontSize: 18, fontFamily: 'Cairo'),
            // padding: const EdgeInsets.symmetric(horizontal: 16),
            value: selectedValue,
            onChanged: (String? newValue) 
            {
              if(hint == 'البلد')
              { BlocProvider.of<SignUpCubit>(context).changeCountry(newValue!); }
              else if(hint == 'خطة الاشتراك')
              { BlocProvider.of<SignUpCubit>(context).changeSubscriptionPlan(newValue!); }
              else if(hint == 'المحافظة')
              { BlocProvider.of<SignUpCubit>(context).changeProvince(newValue!); }
              if(hint == 'الشركة التي تنتسب لها')
              { BlocProvider.of<SignUpCubit>(context).changeCompany(newValue!); }
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
        ),
      ],
    );
  }
}