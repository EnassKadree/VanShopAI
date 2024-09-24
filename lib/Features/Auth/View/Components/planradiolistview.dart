import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Auth/Controller/Subscription%20Plan%20Cubit/subscription_plan_cubit.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';

class PlanRadioListView extends StatelessWidget 
{
  const PlanRadioListView(
      {super.key,
      required this.type});
      final String type;

  @override
  Widget build(BuildContext context) 
  {
    final cubit = BlocProvider.of<PlanCubit>(context);
    return BlocBuilder<PlanCubit, PlanState>
    (
      builder: (context, state) 
      {
        return Expanded
        (
          child: ListView.builder
          (
          itemCount: type == companiesConst? cubit.companies.length : cubit.distributors.length,
          itemBuilder: ((context, index) 
          {
            return Column
            (
              children: [
                RadioListTile<String>
                (
                    title: Text
                    (
                      type == companiesConst? cubit.companies[index] : cubit.distributors[index],
                      style: const TextStyle
                      (
                        fontSize: 18,
                      ),
                    ),
                    value: type == companiesConst? cubit.companies[index] : cubit.distributors[index],
                    groupValue: 
                      type == companiesConst && cubit.companies.isNotEmpty ?
                        cubit.selectedCompanyPlan ?? cubit.companies.first
                      : 
                        cubit.selectedDistributorPlan ?? cubit.distributors.first,
                    onChanged: (value) 
                    {
                      if (type == companiesConst) 
                      {
                        cubit.changeCompanyPlan(value!);
                      }
                      else
                      {
                        cubit.changeDistributorPlan(value!);
                      }
                    }),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Divider(thickness: .4),
                )
              ],
            );
          }),
        ));
      },
    );
  }
}
