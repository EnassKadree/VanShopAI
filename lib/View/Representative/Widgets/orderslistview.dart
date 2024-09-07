import 'package:flutter/material.dart';
import 'package:vanshopai/Model/order.dart';

import 'ordercard.dart';

class OrdersListView extends StatelessWidget 
{
  const OrdersListView({super.key, required this.orders});
  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) 
  {
    return ListView.builder
    (
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, index) 
      {
        final order = orders[index];
        return Column
        (
          children: 
          [
            OrderCard(order: order),
          ],
        );
      }
    );
  }
}