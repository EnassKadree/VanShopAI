import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Representative/Add%20Rep%20Store%20Cubit/add_rep_store_cubit.dart';
import 'package:vanshopai/Helper/snackbar.dart';
import 'package:vanshopai/View/General%20Widgets/storecard.dart';

import '../../../Model/store.dart';

class StoresListView extends StatelessWidget 
{
  const StoresListView(
      {super.key, required this.stores, required this.recommended, required this.sender});

  final List<Store> stores;
  final bool recommended;
  final String sender;

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
            return StoreCard(store: store, recommended: recommended, sender: sender,);
          }),
        );
      },
    );
  }
}
