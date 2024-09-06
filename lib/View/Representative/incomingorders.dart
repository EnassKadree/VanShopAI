
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Representative/Get%20Orders%20Cubit/get_incoming_orders_cubit.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/View/General%20Widgets/progressindicator.dart';
import 'package:vanshopai/View/Representative/orderdetails.dart';

import '../../Helper/text.dart';

class IncomingOrdersPage extends StatelessWidget 
{
  const IncomingOrdersPage({super.key});

  @override
  Widget build(BuildContext context) 
  {
    final cubit = BlocProvider.of<GetIncomingOrdersCubit>(context);
    cubit.getIncomingOrders();
    return Scaffold
    (
      body: Padding
      (
        padding: const EdgeInsets.all(16.0),
        child: ListView
        (
          children: [
            TitleText('الطلبيات الواردة', fontSize: 32),
            const SizedBox(height: 16),
            BlocBuilder<GetIncomingOrdersCubit, GetIncomingOrdersState>
            (
              builder: (context, state) 
              {
                if(state is GetIncomingOrdersLoading)
                {
                  return const Column
                  (
                    children: 
                    [ 
                      SizedBox(height: 32,),
                      MyProgressIndicator()
                    ]
                  );
                }
                else if(state is GetIncomingOrdersFailure)
                {
                  return const Column
                  (
                    children: 
                    [
                      SizedBox(height: 32,),
                      Center(child: Text('failed'),),
                    ],
                  );
                }
                if(cubit.orders.isEmpty)
                {
                  return Column
                  (
                    children:
                    [
                      const SizedBox(height: 32,),
                      Row
                      (
                        mainAxisSize: MainAxisSize.min,
                        children: 
                        [
                          Icon(Icons.done_all, color: Colors.blue[600],size: 24,),
                          const SizedBox(width: 6,),
                          const Text('لا يوجد أي طلبات واردة!', style: TextStyle(fontSize: 18, color: Colors.grey),),
                        ],
                      )
                    ]
                  );
                }
                return ListView.builder
                (
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cubit.orders.length,
                  itemBuilder: (context, index) 
                  {
                    final order = cubit.orders[index];
                    final storeName = cubit.storesNames[index];
                    return Column
                    (
                      children: 
                      [
                        Card
                        (
                          color: Colors.white,
                          shadowColor: Colors.grey[100]!.withOpacity(.5),
                          child: ListTile
                          (
                            contentPadding: const EdgeInsets.all(4),
                            title: Text
                              ('  طلبية$storeName', style: TextStyle(fontSize: 22, color: Colors.blue[900]),),
                            subtitle: 
                              Text(formatDate(order.createdAt), style: const TextStyle(color: Colors.brown),),
                            onTap: ()
                            {
                              navigateTo(context, OrderDetailsPage(order: order, storeName: storeName));
                            },
                          ),
                        ),
                      ],
                    );
                  }
                );
              },
            )
          ],
        ),
      ),
    );
  }

  String formatDate(date)
  {
    if(date == null) return '';
    return '${date!.day}/${date!.month}/${date!.year}';
  }
}
