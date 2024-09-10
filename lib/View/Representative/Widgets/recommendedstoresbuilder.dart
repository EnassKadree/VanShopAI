
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/View/Representative/Widgets/repstoreselistview.dart';
import 'package:vanshopai/constants.dart';

import '../../../Cubits/Representative/Get Stores Cubit/get_stores_cubit.dart';
import '../../General Widgets/progressindicator.dart';

recommendedStoresBuilder(context, state) 
{
  final cubit = BlocProvider.of<GetStoresCubit>(context);
  if (state is GetStoresLoading) 
  {
    return const MyProgressIndicator();
  } else if (state is GetStoresFailure) 
  {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('تعذر تحميل المتاجر!',
              style: TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(
            height: 32,
          ),
          TextButton(
              onPressed: () {
                cubit.getRecommendedStores(representativeConst);
              },
              child: Text(
                'حاول مرة أخرى',
                style: TextStyle(color: Colors.orange[700]!),
              ))
        ],
      ),
    );
  } else {
    if (cubit.recommendedStores.isEmpty) {
      return const Center
      (
          child: Column
          (
            children: 
            [
              SizedBox(height: 32,),
              Text(
                'لا يوجد أي متاجر متاحة لك!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ));
    } else 
    {
      return Expanded(child: RepStoresListView(stores: cubit.recommendedStores, recommended: true,));
    }
  }
}