// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/View/Auth/Login/login.dart';
import 'package:vanshopai/View/Auth/Check%20Categories/checkdistributorcategory.dart';
import 'package:vanshopai/Widgets/custombutton.dart';
import 'package:vanshopai/Widgets/customdropdownbutton.dart';
import 'package:vanshopai/Widgets/customtextfield.dart';
import 'package:vanshopai/Widgets/signupheader.dart';

class DistributorSignupPage extends StatelessWidget 
{
  DistributorSignupPage({super.key});

  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: ListView(
            children: 
            [
              const SignupHeader(),
              Padding
              (
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column
                (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: 
                  [
                    const SizedBox(height: 8,),
                    Row(children: 
                    [
                      Text('إنشاء حساب موزع حر',style: TextStyle(color: Colors.orange[700]!, fontSize: 25),),
                    ],),
                    const SizedBox(
                      height: 20,
                    ),
                            
                    CustomTextFormField(
                      hint: 'الاسم التجاري',
                    ),
                    const SizedBox(height: 10,),
                    CustomTextFormField(
                      hint: 'رقم الهاتف',
                    ),

                    const SizedBox(height: 10,),
                    Row
                    (
                      children: 
                      [
                        Text('اختر البلد', style: TextStyle(color: Colors.blue[900]!, fontSize: 18),),
                        const SizedBox(width: 76,),
                        CustomDropDownButton(values: const ['بلد1', 'بلد2', 'بلد3'],selectedValue: 'بلد1',),
                      ],
                    ),
                    
                    const SizedBox(height: 10,),
                    Row
                    (
                      children: 
                      [
                        Text('اختر المحافظة', style: TextStyle(color: Colors.blue[900]!, fontSize: 18),),
                        const SizedBox(width: 32,),
                        CustomDropDownButton(values: const ['1المحافظة', '2المحافظة', '3المحافظة'],selectedValue: '1المحافظة',),
                      ],
                    ),

                    const SizedBox(height: 10,),
                    Row
                    (
                      children: 
                      [
                        Text('خطة الاشتراك', style: TextStyle(color: Colors.blue[900]!, fontSize: 18),),
                        const SizedBox(width: 32,),
                        CustomDropDownButton(values: const ['خطة اشتراك1', 'خطة اشتراك2', 'خطة اشتراك3'],selectedValue: 'خطة اشتراك1',),
                      ],
                    ),
                    
                    const SizedBox(height: 10,),
                    CustomTextFormField(
                      hint: 'كلمة السر',
                    ),
                    
                    const SizedBox(
                      height: 24,
                    ),
                    CustomButton(
                      text: 'إنشاء حساب',
                      onTap: ()
                      {
                        navigateTo(context, CheckDistributorCategory());
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'هل لديك حساب بالفعل؟',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 8,),
                        InkWell(
                          child: Text('تسجيل الدخول',
                              style: TextStyle(color: Colors.orange[700]!)),
                          onTap: () {
                            navigateTo(context, LoginPage());
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 32,),
                  ],
                ),
              )
            ],
          ),
        ),
      );
  }
}
