
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/Features/Oders/Controller/Get%20Orders%20Cubit/get_orders_cubit.dart';
import 'package:vanshopai/Features/Oders/View/Add%20Order/adddistorderpage.dart';
import 'package:vanshopai/Components/customfloatingactionbuttonadd.dart';
import 'package:vanshopai/Components/progressindicator.dart';
import 'package:vanshopai/Features/Oders/View/Components/orderslistview.dart';
import 'package:vanshopai/Helper/constants.dart';

import '../../../../Helper/text.dart';

class DistIncomingOrdersPage extends StatelessWidget 
{
  const DistIncomingOrdersPage({super.key});

  @override
  Widget build(BuildContext context) 
  {
    final cubit = BlocProvider.of<GetOrdersCubit>(context);
    cubit.getOrders(distributorsConst);
    return Scaffold
    (
      floatingActionButton: const CustomFloatingActionButtonAdd
      (
        label: 'إضافة طلب', 
        rout: AddDistOrderPage()
      ),
      body: Padding
      (
        padding: const EdgeInsets.all(16.0),
        child: ListView
        (
          children: 
          [
            TitleText('الطلبيات الواردة', fontSize: 32),
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
                            onPressed: () async 
                            {
                              await cubit.getOrders(distributorsConst);
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
                if(cubit.incomingOrders.isEmpty)
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
                          Icon(Iconsax.tick_circle, color: Colors.blue[600],size: 24,),
                          const SizedBox(width: 6,),
                          const Text('لا يوجد أي طلبات واردة!', style: TextStyle(fontSize: 18, color: Colors.grey),),
                        ],
                      )
                    ]
                  );
                }
                return OrdersListView(orders: cubit.incomingOrders, sender: distributorsConst,);
              },
            )
          ],
        ),
      ),
    );
  }
}
