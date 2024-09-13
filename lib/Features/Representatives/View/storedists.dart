import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Representatives/Controller/Store%20Dists/store_dists_cubit.dart';
import 'package:vanshopai/Features/Representatives/View/Components/storedistslistview.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';
import 'package:vanshopai/Features/Core/Helper/text.dart';
import 'package:vanshopai/Components/progressindicator.dart';

class StoreDists extends StatelessWidget 
{
  const StoreDists({super.key});

  @override
  Widget build(BuildContext context) 
  {
    StoreDistsCubit cubit = BlocProvider.of<StoreDistsCubit>(context);
    cubit.getDists();
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
              'مندوبو الشركات',
              fontSize: 32
            ),
            const SizedBox(height: 12,),
            BlocBuilder<StoreDistsCubit, StoreDistsState>
            (
              builder: (context, state) 
              {
                return distsBuilder(state, cubit, false);
              },
            ),
            const SizedBox(height: 12,),
            const Divider(),
            const SizedBox(height: 12,),
            TitleText
            (
              'الموزعون',
              fontSize: 32
            ),
            const SizedBox(height: 12,),
            BlocBuilder<StoreDistsCubit, StoreDistsState>
            (
              builder: (context, state) 
              {
                return distsBuilder(state, cubit, true);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget distsBuilder(StoreDistsState state, StoreDistsCubit cubit, bool dist) 
  {
    if(state is StoreDistsLoading)
      {
        return const MyProgressIndicator();
      }
      else if(state is StoreDistsFailure)
      {
        return Center
        (
          child: Column
          (
            crossAxisAlignment: CrossAxisAlignment.center,
            children: 
            [
              const Text('تعذر التحميل ', style: TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 32,),
              TextButton
              (
                onPressed: ()
                { cubit.getDists(); }, 
                child: Text('حاول مرة أخرى', style: TextStyle(color: Colors.orange[700]!),)
              )
            ],
        ),);
      }
      else
      {
        if(dist)
        {
          if(cubit.distributors.isEmpty)
          {
            return const Center(child: Text('لم يتعامل حسابك مع أي موزعين بعد', style: TextStyle(fontSize: 18, color: Colors.grey),));
          }
          else
          {
            return const StoreDistsListView(sender: distributorsConst,);
          }
        }
        else
        {
          if(cubit.representatives.isEmpty)
          {
            return const Center(child: Text('لم يتعامل حسابك مع أي مندوبين بعد', style: TextStyle(fontSize: 18, color: Colors.grey),));
          }
          else
          {
            return const StoreDistsListView(sender: representativeConst,);
          }
        }
      }
  }
}
