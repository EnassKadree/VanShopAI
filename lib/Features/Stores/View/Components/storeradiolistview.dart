import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Stores/Controller/Get%20Stores%20Cubit/get_stores_cubit.dart';
import 'package:vanshopai/Features/Core/Model/store.dart';

class StoreRadioListView extends StatelessWidget 
{
  const StoreRadioListView
  ({super.key});

  @override
  Widget build(BuildContext context) 
  {
    final cubit = BlocProvider.of<GetStoresCubit>(context);
    return BlocBuilder<GetStoresCubit, GetStoresState>
    (
      builder: (context, state) 
      {
        return ListView.builder
        (
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cubit.stores.length,
          itemBuilder: ((context, index) 
          {
            return Column
            (
              children: 
              [
                RadioListTile<Store>
                (
                    title: Text
                    (
                      cubit.stores[index].tradeName,
                      style: TextStyle
                      (
                        fontSize: 18,
                        color: Colors.blue[900]
                      ),
                    ),
                    value: cubit.stores[index],
                    groupValue: cubit.stores.isNotEmpty ?
                        cubit.selectedStore ?? cubit.stores.first
                      : null,
                    onChanged: (value) 
                    {
                      cubit.changeStore(value);
                    }),
                const Padding
                (
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Divider(thickness: .4),
                )
              ],
            );
          }),
        );
      },
    );
  }
}
