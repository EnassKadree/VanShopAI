import 'package:flutter/material.dart';
import 'package:vanshopai/Model/order.dart';

import 'ordercard.dart';

class OrdersListView extends StatelessWidget 
{
  const OrdersListView({super.key, required this.orders, required this.sender});
  final List<OrderModel> orders;
  final String sender;

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
            OrderCard(order: order, sender: sender,),
          ],
        );
      }
    );
  }
}