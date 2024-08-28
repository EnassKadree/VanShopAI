// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Auth/Categories%20Cubit/categories_cubit.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/Helper/snackbar.dart';
import 'package:vanshopai/View/Auth/Check%20Plan/companyplan.dart';
import 'package:vanshopai/View/Widgets/checkboxlistview.dart';
import 'package:vanshopai/View/Widgets/custombutton.dart';
import 'package:vanshopai/constants.dart';

class CheckCompanyCategories extends StatelessWidget 
{
  const CheckCompanyCategories({super.key});

  @override
  Widget build(BuildContext context) 
  {
    final cubit = BlocProvider.of<CategoriesCubit>(context);
    cubit.fetchCategories();
    return Scaffold
    (
      body: BlocConsumer<CategoriesCubit, CategoriesState>
      (
        listener: (context,state)
        {
          if(state is SaveCategoriesFailure)
          {
            ShowSnackBar(context, state.error);
          }
          else if(state is SaveCategoriesSuccess)
          {
            navigateTo(context, const CheckCompanyPlan());
          }
        },
        builder: (context, state) 
        {
          if(state is CategoriesLoading || state is SaveCategoriesLoading)
          {
            return  Center(child: CircularProgressIndicator(color: Colors.orange[700]!),);
          }
          else if(state is CategoriesFailure)
          {
            return Center
            (
              child: Column
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: 
                [
                  const Text('تعذر تحميل الفئات!'),
                  const SizedBox(height: 24,),
                  TextButton
                  (
                    onPressed: () async
                    {
                      await cubit.fetchCategories();
                    }, 
                    child: Text('حاول مرة أخرى', style: TextStyle(color: Colors.orange[700]!),)
                  )
                ],
              ),
            );
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
                  'ما هي منتجات شركتك؟',
                  style: TextStyle(
                      color: Colors.orange[700]!,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                CheckBoxListView(),
                CustomButton
                (
                  text: 'تم',
                  onTap: () async
                  {
                    await cubit.saveUserCategories(companiesConst);
                  },
                )
              ],
            ),
          );
        },
      )
    );
  }
}
