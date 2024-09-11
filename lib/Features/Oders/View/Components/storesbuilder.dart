
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Stores/Controller/Get Stores Cubit/get_stores_cubit.dart';
import '../../../../Components/progressindicator.dart';
import '../../../Stores/View/Components/storeradiolistview.dart';

storesBuilder(context, state, sender) 
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
                cubit.getStores(sender);
              },
              child: Text(
                'حاول مرة أخرى',
                style: TextStyle(color: Colors.orange[700]!),
              ))
        ],
      ),
    );
  } else {
    if (cubit.stores.isEmpty) {
      return const Center
      (
          child: Column
          (
            children: 
            [
              SizedBox(height: 32,),
              Text(
                'لا يوجد أي متاجر في قائمة زبائنك!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ));
    } else {
      return const StoreRadioListView();
    }
  }
}