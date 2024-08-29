
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Company/Represntatives%20Cubit/representatives_cubit.dart';
import 'package:vanshopai/View/Widgets/representativecard.dart';

class CompanyRepresentativesListView extends StatelessWidget 
{
  const CompanyRepresentativesListView
  ({
    super.key, required this.submitted
  });
  final bool submitted;


  @override
  Widget build(BuildContext context) 
  {
    RepresentativesCubit cubit =   BlocProvider.of<RepresentativesCubit>(context);
    return ListView.builder
    (
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: submitted? 
      cubit.representatives.length 
    :
      cubit.representativesRequests.length,
    itemBuilder: (context, index) 
    {
      return RepresentativeCard
      (
        submitted: submitted, 
        representative: submitted? cubit.representatives[index] : cubit.representativesRequests[index]
      );
    });
  }
}
