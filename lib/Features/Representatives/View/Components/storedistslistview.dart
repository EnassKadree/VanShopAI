
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Representatives/Controller/Store%20Dists/store_dists_cubit.dart';
import 'package:vanshopai/Features/Representatives/View/Components/storedistscard.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';

class StoreDistsListView extends StatelessWidget 
{
  const StoreDistsListView
  ({
    super.key, required this.sender
  });
  final String sender;


  @override
  Widget build(BuildContext context) 
  {
    bool dist = sender == distributorsConst;
    StoreDistsCubit cubit =   BlocProvider.of<StoreDistsCubit>(context);
    return ListView.builder
    (
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dist? cubit.distributors.length : cubit.representatives.length,
      itemBuilder: (context, index) 
      {
        if(dist)
        { return StoreDistCard(distributor: cubit.distributors[index]); }
        else
        { return StoreDistCard(representative: cubit.representatives[index], companyName: cubit.companyNames[index],); }
      }
    );
  }
}
