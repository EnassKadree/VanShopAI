
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';
import 'package:vanshopai/Features/Orders/Controller/Get%20Orders%20Cubit/get_orders_cubit.dart';
import 'package:vanshopai/Features/Orders/Controller/Update%20Order/update_order_cubit.dart';
import 'package:vanshopai/Features/Core/Helper/snackbar.dart';

import '../../../Core/Helper/navigators.dart';
import '../../../Core/Helper/orderfunctions.dart';
import '../../../Core/Model/order.dart';
import '../Get Orders/orderdetails.dart';

class OrderCard extends StatelessWidget 
{
  const OrderCard
  ({
    super.key,
    required this.order, required this.sender, this.distName
  });

  final OrderModel order;
  final String sender;
  final String? distName;

  @override
  Widget build(BuildContext context) 
  {
    final title = sender == storesConst ? distName : order.storeName;
    return Card
    (
      color: Colors.white,
      shadowColor: Colors.grey[100]!.withOpacity(.5),
      child: ListTile
      (
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text
          ('طلبية $title', style: TextStyle(fontSize: 22, color: Colors.blue[900]),),
        subtitle: 
          Text(formatDate(order.createdAt), style: const TextStyle(color: Colors.brown),),
        trailing: 
        order.status == 'قيد التجهيز'?
          BlocConsumer<UpdateOrderCubit, UpdateOrderState>
          (
            listener: (context, state) 
            {
              if(state is UpdateOrderFailure)
              {
                ShowSnackBar(context, 'تعذر تعديل الطلب');
              }
              if(state is UpdateOrderSuccess)
              {
                ShowSnackBar(context, 'تم تعديل الطلب بنجاح');
              }
            },
            builder: (context, state) 
            {
              if(state is UpdateOrderLoading)
              {
                return Card
                (
                  shape: const CircleBorder(),
                  child: CircularProgressIndicator(color: Colors.blue[700],),
                );
              }
              return Card
              (
                shape: const CircleBorder(),
                child: IconButton
                (
                  color: Colors.blue[700],
                  iconSize: 28,
                  onPressed: ()
                  {
                    showDialog
                    (
                      context: context, 
                      builder: (context)
                      {
                        return AlertDialog
                        (
                          title: Text('تسليم الطلب', style: TextStyle(color: Colors.orange[700])),
                          content: const Text('هل تريد تحويل الطلب إلى الطلبات المنتهية (المستلمة)؟'),
                          actions: 
                          [
                            TextButton
                            (
                              child: const Text('إلغاء'),
                              onPressed: (){pop(context);},
                            ),
                            TextButton
                            (
                              onPressed: ()
                              {
                                BlocProvider.of<UpdateOrderCubit>(context).updateOrderStatus(order);
                                BlocProvider.of<GetOrdersCubit>(context).getOrders(sender, false);
                                pop(context);
                              }, 
                              child: Text('تسليم', style: TextStyle(color: Colors.orange[700]),)
                            )
                          ],
                        );
                      }
                    );
                  }, icon: const Icon(Iconsax.tick_circle)
                ),
              );
            },
          )
        :
          null,
        onTap: ()
        {
          navigateTo(context, OrderDetailsPage(order: order));
        },
      ),
    );
  }
}