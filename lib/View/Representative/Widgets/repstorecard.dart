
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/Cubits/Representative/Add%20Rep%20Store%20Cubit/add_rep_store_cubit.dart';
import 'package:vanshopai/Cubits/Representative/Get%20Stores%20Cubit/get_stores_cubit.dart';

import '../../../Helper/navigators.dart';
import '../../../Model/store.dart';

class RepStoreCard extends StatelessWidget 
{
  const RepStoreCard
  ({
    super.key,
    required this.store,
    required this.recommended
  });

  final Store store;
  final bool recommended;

  @override
  Widget build(BuildContext context) 
  {
    final cubit = BlocProvider.of<GetStoresCubit>(context);
    return Card
    (
      color: Colors.white,
      shadowColor: Colors.grey[100]!.withOpacity(.5),
      child: ListTile
      (
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
        title: Text(store.tradeName, style: TextStyle(fontSize: 22, color: Colors.blue[900]),),
        trailing:
        Row
        (
          mainAxisSize: MainAxisSize.min, 
          children:
          [
            IconButton
            (
              onPressed: () async
              {
                showDialog
                (
                  context: context, 
                  builder: (context)
                  {
                    return AlertDialog
                    (
                      title: Text('العنوان:', style:TextStyle(color:Colors.orange[700])),
                      content: Text(store.address, style: const TextStyle(fontSize:18),),
                      actions: 
                      [
                        TextButton
                        (
                          onPressed: ()
                          {
                            pop(context);
                          },
                          child: Text('تم', style: TextStyle(color:Colors.blue[900])),
                        )
                      ],
                    );
                  }
                );
              },
              icon: Icon(Iconsax.location ,color: Colors.blue[600],size: 28,)
            ),
            recommended? 
              IconButton
              (
                onPressed: ()
                {
                  showDialog
                  (
                    context: context, 
                    builder: (context)
                    {
                      return AlertDialog
                      (
                        title: Text('إضافة زبون', style:TextStyle(color:Colors.orange[700])),
                        content: const Text('هل تريد إضافة هذا الزبون إلى قائمة زبائنك', style: TextStyle(fontSize:16),),
                        actions: 
                        [
                          TextButton
                          (
                            onPressed: ()
                            {
                              pop(context);
                            }, 
                            child: const Text('لا', style: TextStyle(color:Colors.brown))
                          ),
                          TextButton
                          (
                            onPressed: () async
                            {
                              
                              await BlocProvider.of<AddRepStoreCubit>(context).addRepStore(store, cubit);
                              pop(context);
                            }, 
                            child: Text('نعم', style: TextStyle(color:Colors.blue[900]))
                          ),
                        ],
                      );
                    }
                  );
                }, 
                icon: Icon(Iconsax.add ,color: Colors.blue[600],size: 28,)
              )
            :
              IconButton
              (
                onPressed: () async
                {
                  await FlutterPhoneDirectCaller.callNumber(store.phone);
                },
                icon: Icon(Iconsax.call ,color: Colors.blue[600],size: 28,)
              ),
          ]
        )
      ),
    );
  }
}