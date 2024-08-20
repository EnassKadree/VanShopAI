// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Auth/Signup%20Cubit/sign_up_cubit.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/Helper/snackbar.dart';
import 'package:vanshopai/View/Auth/Check%20Categories/checkcompanycategory.dart';
import 'package:vanshopai/View/Auth/Login/login.dart';
import 'package:vanshopai/Widgets/custombutton.dart';
import 'package:vanshopai/Widgets/customdropdownbutton.dart';
import 'package:vanshopai/Widgets/customtextfield.dart';
import 'package:vanshopai/Widgets/signupheader.dart';

class CompanySignupPage extends StatelessWidget 
{
  CompanySignupPage({super.key});

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController tradeName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) 
  {
    return BlocConsumer<SignUpCubit, SignUpState>
    (
      listener: (context, state) 
      {
        if (state is SignUpSuccess) 
        {
          ShowSnackBar(context, 'لقد أرسلنا رابطاً إلى بريدك الإلكتروني يرجى فتحه للتحقق من حسابك ثم القيام بتسجيل الدخول بعد تحديد أصناف شركتك');
          navigateTo(context, const CheckCompanyCategory());
        } 
        else if (state is SignUpFailure) 
        {
          ShowSnackBar(context, state.error);
        }
      },
      builder: (context, state) 
      {
        return Scaffold
        (
          backgroundColor: Colors.white,
          body: Form(
            key: formKey,
            child: ListView
            (
              children: 
              [
                const SignupHeader(),
                state is SignUpLoading?
                  Center(child: CircularProgressIndicator(color: Colors.orange[800]!,),)
                :
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
                        Text('إنشاء حساب شركة',style: TextStyle(color: Colors.orange[700]!, fontSize: 25),),
                      ],),
                      const SizedBox(
                        height: 20,
                      ),
                              
                      CustomTextFormField
                      (
                        hint: 'الاسم التجاري',
                        controller: tradeName,
                      ),
                      const SizedBox(height: 10,),
                      CustomTextFormField
                      (
                        hint: 'رقم الهاتف',
                        controller: phoneNumber,
                      ),
                      
                      const SizedBox(height: 10,),
                      CustomDropDownButton
                      (
                        hint: 'البلد',
                        values: const ['بلد1', 'بلد2', 'بلد3'],
                        selectedValue: state is CountryChanged 
                          ? state.selectedCountry 
                          : BlocProvider.of<SignUpCubit>(context).selectedCountry
                      ),
                      
                      const SizedBox(height: 10,),
                      CustomDropDownButton
                      (
                        hint: 'خطة الاشتراك',
                        values: const ['خطة اشتراك1', 'خطة اشتراك2', 'خطة اشتراك3'],
                        selectedValue: state is SubscriptionPlanChanged 
                          ? state.selectedPlan 
                          : BlocProvider.of<SignUpCubit>(context).selectedPlan,
                      ),
                      
                      const SizedBox(height: 10,),
                      CustomTextFormField
                      (
                        hint: 'البريد الإلكتروني',
                        controller: email,
                      ),

                      const SizedBox(height: 10,),
                      CustomTextFormField
                      (
                        hint: 'كلمة السر',
                        controller: password,
                      ),

                      const SizedBox(
                        height: 24,
                      ),
                      CustomButton(
                        text: 'إنشاء حساب',
                        onTap: () async
                        {
                          if(formKey.currentState!.validate())
                          {
                            BlocProvider.of<SignUpCubit>(context).createAccount
                            (
                              email: email.text, 
                              password: password.text,
                            );
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
    );
  }
}
