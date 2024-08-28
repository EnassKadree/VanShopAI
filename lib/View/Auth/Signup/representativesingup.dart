// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/Helper/snackbar.dart';
import 'package:vanshopai/View/Auth/Login/login.dart';
import 'package:vanshopai/View/Widgets/choicebutton.dart';
import 'package:vanshopai/View/Widgets/custombutton.dart';
import 'package:vanshopai/View/Widgets/customtextfield.dart';
import 'package:vanshopai/View/Widgets/signupheader.dart';
import 'package:vanshopai/Cubits/Auth/Signup%20Account%20Cubit/signup_account_cubit.dart';
import 'package:vanshopai/constants.dart';


class RepresentativeSignupPage extends StatelessWidget 
{
  RepresentativeSignupPage({super.key});

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController tradeName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) 
  {
    SignUpAccountCubit cubit = BlocProvider.of<SignUpAccountCubit>(context);
    return BlocConsumer<SignUpAccountCubit, SignUpAccountState>(
      listener: (context, state) 
      {
        if (state is SignUpAccountSuccess) 
        {
          navigateRemoveUntil(context, LoginPage());
        } 
        else if (state is SignUpAccountFailure) 
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
            child: ListView(
              children: [
                const SignupHeader(),
                state is SignUpAccountLoading?
                Center(child: CircularProgressIndicator(color: Colors.orange[800]!,),)
                :
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'إنشاء حساب مندوب شركة',
                            style: TextStyle(
                                color: Colors.orange[700]!, fontSize: 25),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      CustomTextFormField(hint: 'الاسم التجاري',controller: tradeName,),

                      const SizedBox(height: 10,),
                      CustomTextFormField(hint: 'رقم الهاتف',controller: phoneNumber,),

                      const SizedBox(height: 10,),
                      ChoiceButton
                      (type: companiesConst,),

                      const SizedBox( height: 10,),
                      ChoiceButton(type: countriesConst),
                      
                      const SizedBox(height: 10,),
                      ChoiceButton
                      (type: provincesConst,),
                      const SizedBox( height: 10,),

                      const SizedBox(height: 24,),
                      CustomButton(
                        text: 'التالي',
                        onTap: () 
                        {
                          if(formKey.currentState!.validate())
                          {
                            cubit.createRepresentativeAccount
                            (
                              tradeName: tradeName.text,
                              phone: phoneNumber.text,
                              country: cubit.selectedCountry,
                              province: cubit.selectedProvince,
                              company: cubit.selectedCompany
                            );
                          }
                        },
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
