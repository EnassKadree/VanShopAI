
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Oders/Controller/Get%20Orders%20Cubit/get_orders_cubit.dart';
import 'package:vanshopai/Components/progressindicator.dart';
import 'package:vanshopai/Features/Oders/View/Components/orderslistview.dart';
import 'package:vanshopai/Helper/constants.dart';

import '../../../../Helper/text.dart';

class RepDoneOrdersPage extends StatelessWidget 
{
  const RepDoneOrdersPage({super.key});

  @override
  Widget build(BuildContext context) 
  {
    final cubit = BlocProvider.of<GetOrdersCubit>(context);
    cubit.getOrders(representativeConst);
    return Scaffold
    (
      body: Padding
      (
        padding: const EdgeInsets.all(16.0),
        child: ListView
        (
          children: 
          [
            TitleText('الطلبيات المنتهية', fontSize: 32),
            const SizedBox(height: 16),
            BlocBuilder<GetOrdersCubit, GetOrdersState>
            (
              builder: (context, state) 
              {
                if(state is GetOrdersLoading)
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
                else if(state is GetOrdersFailure)
                {
                  return Center
                  (
                    child: Column
                    (
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('تعذر تحميل الطلبات!'),
                        const SizedBox(
                          height: 16,
                        ),
                        TextButton(
                            onPressed: () async {
                              await cubit.getOrders(representativeConst);
                            },
                            child: Text
                            (
                              'حاول مرة أخرى',
                              style: TextStyle(color: Colors.orange[700]!),
                            ))
                      ],
                    ),
                  );
                }
                if(cubit.doneOrders.isEmpty)
                {
                  return const Column
                  (
                    children:
                    [
                      SizedBox(height: 32,),
                      Text('لا يوجد أي طلبات منتهية!', style: TextStyle(fontSize: 18, color: Colors.grey),)
                    ]
                  );
                }
                return OrdersListView(orders: cubit.doneOrders, sender: representativeConst,);
              },
            )
          ],
        ),
      ),
    );
  }
}
