import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Representative/Add%20Rep%20Store%20Cubit/add_rep_store_cubit.dart';
import 'package:vanshopai/Helper/snackbar.dart';
import 'package:vanshopai/View/Representative/Widgets/repstorecard.dart';

import '../../../Model/store.dart';

class RepStoresListView extends StatelessWidget {
  const RepStoresListView(
      {super.key, required this.stores, required this.recommended});

  final List<Store> stores;
  final bool recommended;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddRepStoreCubit, AddRepStoreState>
    (
      listener: (context, state) 
      {
        if(state is AddRepStoreSuccess)
        {
          ShowSnackBar(context, 'تم إضافة المتجر إلى قائمة زبائنك بنجاح');
        }
        if(state is AddRepStoreFailure)
        {
          ShowSnackBar(context, 'تعذر إضافة المتجر إلى قائمة زبائنك');
        }
      },
      builder: (context, state) {
        return ListView.builder
        (
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: stores.length,
          itemBuilder: ((context, index) 
          {
            Store store = stores[index];
            return RepStoreCard(store: store, recommended: recommended);
          }),
        );
      },
    );
  }
}
