import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';
import 'package:vanshopai/Features/Core/Model/order.dart';
import 'package:vanshopai/Features/Orders/Controller/Get%20Orders%20Cubit/get_orders_cubit.dart';

import 'ordercard.dart';

class OrdersListView extends StatelessWidget 
{
  const OrdersListView({super.key, required this.orders, required this.sender});
  final List<OrderModel> orders;
  final String sender;

  @override
  Widget build(BuildContext context) 
  {
    final cubit = BlocProvider.of<GetOrdersCubit>(context);
    return ListView.builder
    (
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, index) 
      {
        final order = orders[index];
        final distName = sender == storesConst? cubit.distsNames[index] : null;
        return Column
        (
          children: 
          [
            OrderCard(order: order, sender: sender, distName: distName,)
          ]
        );
      }
    );
  }
}