// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Auth/Login%20Cubit/login_cubit.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/Helper/snackbar.dart';
import 'package:vanshopai/View/Auth/Other/usertype.dart';
import 'package:vanshopai/View/Company/companyhome.dart';
import 'package:vanshopai/Widgets/custombutton.dart';
import 'package:vanshopai/Widgets/customtextfield.dart';
import 'package:vanshopai/Widgets/signupheader.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>
    (
      listener: (context, state) 
      {
        if (state is LoginSuccess) 
        {
          navigateRemoveUntil(context, const CompanyHome());
        } 
        else if (state is LoginFailure) 
        {
          ShowSnackBar(context, state.error);
        }
      },
      builder: (context, state) 
      {
        return Scaffold
        (
          backgroundColor: Colors.white,
          body: Form
          (
            key: formKey,
            child: ListView
            (
              children: 
              [
                const SignupHeader(),
                state is LoginLoading? 
                Center(child: CircularProgressIndicator(color: Colors.orange[800]!,),)
                :Padding
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
                        hint: 'البريد الإلكتروني',
                        controller: email,
                      ),
                      const SizedBox(height: 10,),
                      CustomTextFormField(
                        hint: 'كلمة السر',
                        controller: password,
                      ),
                      
                      const SizedBox(
                        height: 24,
                      ),

                      CustomButton(
                        text: 'تسجيل الدخول',
                        onTap: ()
                        {
                          if(formKey.currentState!.validate())
                          {
                            BlocProvider.of<LoginCubit>(context).singIn(email: email.text, password: password.text);
                          }
                          else
                          {
                            debugPrint('==========================problem here======================');
                          }
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
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
