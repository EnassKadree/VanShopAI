// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/View/Auth/Check%20Categories/checkcompanycategory.dart';
import 'package:vanshopai/View/Auth/Other/usertype.dart';
import 'package:vanshopai/Widgets/custombutton.dart';
import 'package:vanshopai/Widgets/customtextfield.dart';
import 'package:vanshopai/Widgets/signupheader.dart';

class LoginPage extends StatelessWidget 
{
  LoginPage({super.key});

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
                      Text('تسجيل الدخول',style: TextStyle(color: Colors.orange[700]!, fontSize: 25),),
                    ],),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hint: 'رقم الهاتف',
                    ),
                    const SizedBox(height: 10,),
                    CustomTextFormField(
                      hint: 'كلمة السر',
                    ),
                    
                    const SizedBox(
                      height: 24,
                    ),

                    CustomButton(
                      text: 'تسجيل الدخول',
                      onTap: ()
                      {
                        navigateTo(context, const CheckCompanyCategory());
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'أليس لديك حساب بعد؟',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 8,),
                        InkWell(
                          child: Text('إنشاء حساب',
                              style: TextStyle(color: Colors.orange[700]!)),
                          onTap: () {
                            navigateTo(context, const CheckUserType());
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
