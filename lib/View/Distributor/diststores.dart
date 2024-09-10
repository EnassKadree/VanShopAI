import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Helper/text.dart';
import 'package:vanshopai/View/Distributor/adddiststore.dart';
import 'package:vanshopai/View/General%20Widgets/customfloatingactionbuttonadd.dart';
import 'package:vanshopai/View/Representative/Widgets/storeselistview.dart';
import 'package:vanshopai/constants.dart';

import '../../Cubits/Representative/Get Stores Cubit/get_stores_cubit.dart';
import '../General Widgets/progressindicator.dart';

class DistStores extends StatelessWidget 
{
  const DistStores({super.key});

  @override
  Widget build(BuildContext context) 
  {
    final cubit = BlocProvider.of<GetStoresCubit>(context);
    cubit.getStores(distributorsConst);
    return Scaffold
    (
      floatingActionButton: const CustomFloatingActionButtonAdd
      (
        heroTag: 'fab_rep_stores', 
        label: 'إضافة زبون',
        rout: AddDistStorePage()
      ),
      body: Padding
      (
        padding: const EdgeInsets.all(16.0),
        child: ListView
        (
          children: 
          [
            TitleText('زبائني', fontSize: 32),
            const SizedBox(height: 16),
            BlocBuilder<GetStoresCubit, GetStoresState>
            (
              builder: (context, state) 
              {
                if (state is GetStoresLoading) 
                {
                  return const Column
                  (
                    children: 
                    [
                      SizedBox(height: 32),
                      MyProgressIndicator(),
                    ],
                  );
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
                              cubit.getStores(distributorsConst);
                            },
                            child: Text(
                              'حاول مرة أخرى',
                              style: TextStyle(color: Colors.orange[700]!),
                            ))
                      ],
                    ),
                  );
                } else 
                {
                  if (cubit.stores.isEmpty) 
                  {
                    return const Center
                    (
                      child: Column
                      (
                        children: 
                        [
                          SizedBox(height: 32,),
                          Text
                          (
                            'لا يوجد متاجر في قائمة زبائنك !',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  } else 
                  {
                    return StoresListView(stores: cubit.stores, recommended: false,sender: distributorsConst,);
                  }
                }
              }
            ),
          ],
        ),
      )
    );
  }
}
