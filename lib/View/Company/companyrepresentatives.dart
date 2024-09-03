import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Company/Represntatives%20Cubit/representatives_cubit.dart';
import 'package:vanshopai/View/Company/Widgets/companyrepresentativelistview.dart';
import 'package:vanshopai/View/Widgets/progressindicator.dart';

class CompanyRepresentatives extends StatelessWidget 
{
  const CompanyRepresentatives({super.key});

  @override
  Widget build(BuildContext context) 
  {
    RepresentativesCubit cubit = BlocProvider.of<RepresentativesCubit>(context);
    cubit.getRepresentatives();
    return Scaffold
    (
      body: Padding
      (
        padding: const EdgeInsets.all(16),
        child: ListView
        (
          children: 
          [
            Text
            (
              'طلبات المصادقة',
              style: TextStyle
              (
                color: Colors.orange[700]!,
                fontSize: 36,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 12,),

            BlocBuilder<RepresentativesCubit, RepresentativesState>
            (
              builder: (context, state) 
              {
                return repRequestBuilder(state, cubit);
              },
            ),
            const SizedBox(height: 24,),
            const Divider(),
            const SizedBox(height: 12,),

            Text
            (
              'مندوبو الشركة',
              style: TextStyle
              (
                color: Colors.orange[700]!,
                fontSize: 36,
                fontWeight: FontWeight.bold
              ),
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
                { cubit.getRepresentatives(); }, 
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
                Icon(Icons.done_all, color: Colors.blue[600],size: 24,),
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
                { cubit.getRepresentatives(); }, 
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
