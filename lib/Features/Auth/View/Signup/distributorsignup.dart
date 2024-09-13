// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Core/Helper/navigators.dart';
import 'package:vanshopai/Features/Core/Helper/snackbar.dart';
import 'package:vanshopai/Features/Auth/View/Check%20Categories/checkdistributorcategory.dart';
import 'package:vanshopai/Features/Auth/Controller/Signup%20Account%20Cubit/signup_account_cubit.dart';
import 'package:vanshopai/Features/Auth/View/Components/choicebutton.dart';
import 'package:vanshopai/Features/Auth/View/Components/signupheader.dart';
import 'package:vanshopai/Features/Orders/View/Components/custombutton.dart';
import 'package:vanshopai/Components/customtextfield.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';

class DistributorSignupPage extends StatelessWidget {
  const DistributorSignupPage({super.key});


  @override
  Widget build(BuildContext context) 
  {
    final GlobalKey<FormState> formKey = GlobalKey();
    final TextEditingController tradeName = TextEditingController();
    final TextEditingController phoneNumber = TextEditingController();
    SignUpAccountCubit cubit = BlocProvider.of<SignUpAccountCubit>(context);
    return BlocConsumer<SignUpAccountCubit, SignUpAccountState>
    (
      listener: (context, state) 
      {
        if (state is SignUpAccountSuccess) 
        {
          navigateRemoveUntil(context, const CheckDistributorCategories());
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
          bottomNavigationBar: Padding
          (
            padding: const EdgeInsets.all(16),
            child: CustomButton(
            text: 'التالي',
            onTap: () 
            {
              if(formKey.currentState!.validate())
              {
                cubit.createDistributorAccount
                (
                  tradeName: tradeName.text,
                  phone: phoneNumber.text,
                  country: cubit.selectedCountry,
                  province: cubit.selectedProvince,
                );
              }
            },
          ),
          ),
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
                        children: 
                        [
                          Text(
                            'إنشاء حساب موزع حر',
                            style: TextStyle(
                                color: Colors.orange[700]!, fontSize: 25),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      CustomTextFormField(hint: 'الاسم التجاري',controller: tradeName,),

                      const SizedBox(height: 10,),
                      CustomTextFormField(hint: 'رقم الهاتف', controller: phoneNumber,),

                      const SizedBox(height: 10,),
                      ChoiceButton(type: countriesConst),

                      const SizedBox(height: 10,),
                      ChoiceButton(type: provincesConst),
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
