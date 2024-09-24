import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/Features/Representatives/Controller/Company%20Representatives/representatives_cubit.dart';
import 'package:vanshopai/Features/Core/Helper/text.dart';
import 'package:vanshopai/Features/Representatives/View/Components/companyrepresentativelistview.dart';
import 'package:vanshopai/Components/progressindicator.dart';

class CompanyRequests extends StatelessWidget 
{
  const CompanyRequests({super.key});

  @override
  Widget build(BuildContext context) 
  {
    RepresentativesCubit cubit = BlocProvider.of<RepresentativesCubit>(context);
    cubit.getRepresentatives(submitted: false);
    return Scaffold
    (
      body: Padding
      (
        padding: const EdgeInsets.all(16),
        child: ListView
        (
          children: 
          [
            titleText
            (
              'طلبات المصادقة',
              fontSize: 32
            ),
            const SizedBox(height: 12,),

            BlocBuilder<RepresentativesCubit, RepresentativesState>
            (
              builder: (context, state) 
              {
                return repRequestBuilder(state, cubit);
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget repRequestBuilder(RepresentativesState state, RepresentativesCubit cubit) 
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
              const Text('تعذر تحميل طلبات المصادقة!', style: TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 32,),
              TextButton
              (
                onPressed: ()
                { cubit.getRepresentatives(submitted: false); }, 
                child: Text('حاول مرة أخرى', style: TextStyle(color: Colors.orange[700]!),)
              )
            ],
        ),);
      }
      else
      {
        if(cubit.representativesRequests.isEmpty)
        {
          return Center
          (
            child: Row
            (
              mainAxisSize: MainAxisSize.min,
              children: 
              [
                Icon(Iconsax.tick_circle, color: Colors.blue[600],size: 24,),
                const SizedBox(width: 6,),
                const Text('لا يوجد أي طلبات مصادقة!', style: TextStyle(fontSize: 18, color: Colors.grey),),
              ],
            )
          );
        }
        else
        {
          return const CompanyRepresentativesListView(submitted: false);
        }
      }
  }
}