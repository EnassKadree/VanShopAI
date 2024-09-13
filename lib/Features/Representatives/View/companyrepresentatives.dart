import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Representatives/Controller/Company%20Representatives/representatives_cubit.dart';
import 'package:vanshopai/Features/Core/Helper/text.dart';
import 'package:vanshopai/Features/Representatives/View/Components/companyrepresentativelistview.dart';
import 'package:vanshopai/Components/progressindicator.dart';

class CompanyRepresentatives extends StatelessWidget 
{
  const CompanyRepresentatives({super.key});

  @override
  Widget build(BuildContext context) 
  {
    RepresentativesCubit cubit = BlocProvider.of<RepresentativesCubit>(context);
    cubit.getRepresentatives(submitted: true);
    return Scaffold
    (
      body: Padding
      (
        padding: const EdgeInsets.all(16),
        child: ListView
        (
          children: 
          [
            TitleText
            (
              'مندوبو الشركة',
              fontSize: 32
            ),
            const SizedBox(height: 12,),
            BlocBuilder<RepresentativesCubit, RepresentativesState>
            (
              builder: (context, state) 
              {
                return repBuilder(state, cubit);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget repBuilder(RepresentativesState state, RepresentativesCubit cubit) 
  {
    if(state is RepresentativesLoading)
      {
        return const MyProgressIndicator();
      }
      else if(state is RepresentativesFailure)
      {
        return Center
        (
          child: Column
          (
            crossAxisAlignment: CrossAxisAlignment.center,
            children: 
            [
              const Text('تعذر تحميل المندوبين!', style: TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 32,),
              TextButton
              (
                onPressed: ()
                { cubit.getRepresentatives(submitted: true); }, 
                child: Text('حاول مرة أخرى', style: TextStyle(color: Colors.orange[700]!),)
              )
            ],
        ),);
      }
      else
      {
        if(cubit.representatives.isEmpty)
        {
          return const Center(child: Text('لا يوجد مندوبين بعد!', style: TextStyle(fontSize: 18, color: Colors.grey),));
        }
        else
        {
          return const CompanyRepresentativesListView(submitted: true);
        }
      }
  }
}
