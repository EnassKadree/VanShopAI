import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Auth/Subscription%20Plan%20Cubit/subscription_plan_cubit.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/View/Auth/Login/login.dart';
import 'package:vanshopai/Widgets/custombutton.dart';
import 'package:vanshopai/Widgets/planradiolistview.dart';
import 'package:vanshopai/constants.dart';

class CheckDistributorPlan extends StatelessWidget 
{
  const CheckDistributorPlan({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Padding
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
            planRadioListView(type: distributorsConst),
            CustomButton
            (
              text: 'تم',
              onTap: () async
              {
                await BlocProvider.of<PlanCubit>(context).saveUserPlan(distributorsConst);
                navigateRemoveUntil(context, LoginPage());
              },
            )
          ],
        ),
      )
    );
  }
}