import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Auth/Controller/Subscription%20Plan%20Cubit/subscription_plan_cubit.dart';
import 'package:vanshopai/Features/Core/Helper/navigators.dart';
import 'package:vanshopai/Features/Core/Helper/snackbar.dart';
import 'package:vanshopai/Features/Auth/View/Login/login.dart';
import 'package:vanshopai/Features/Auth/View/Components/planradiolistview.dart';
import 'package:vanshopai/Features/Orders/View/Components/custombutton.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';

class CheckCompanyPlan extends StatelessWidget 
{
  const CheckCompanyPlan({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      body: BlocConsumer<PlanCubit,PlanState>
      (
        listener: (context,state)
        {
          if(state is SavePlanFailure)
          {
            showSnackBar(context, state.error!);
          }
          else if(state is SavePlanSuccess)
          {
            navigateRemoveUntil(context, const LoginPage());
          }
        },
        builder: (context, state) 
        {
          if(state is SavePlanLoading)
          {
            return  Center(child: CircularProgressIndicator(color: Colors.orange[700]!),);
          }
          return Padding
          (
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
                const SizedBox(height: 24,),
                Text(
                  'ما خطة الاشتراك التي تفضلها؟',
                  style: TextStyle(
                      color: Colors.orange[700]!,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                const PlanRadioListView(type: companiesConst,),
                CustomButton
                (
                  text: 'تم',
                  onTap: () async
                  {
                    await BlocProvider.of<PlanCubit>(context).saveUserPlan(companiesConst);
                  },
                )
              ],
            ),
          );
        }
      )
    );
  }
}