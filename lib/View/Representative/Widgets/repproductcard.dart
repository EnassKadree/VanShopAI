
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Cubits/Representative/Quantity Cubit/quantity_cubit.dart';
import '../../../Model/product.dart';
import 'quantityselector.dart';

class RepProductCard extends StatelessWidget {
  const RepProductCard({
    super.key,
    required this.product,
    required this.onQuantityChanged
  });

  final Product product;
  final ValueChanged<int> onQuantityChanged;

  @override
  Widget build(BuildContext context) 
  {
    return Card
    (
      shadowColor: Colors.grey[100]!.withOpacity(.5),
      color: Colors.white,
      child: ListTile
      (
        contentPadding: const EdgeInsets.only(right: 10),
        title: Text(product.name, style: TextStyle(color: Colors.blue[900], fontSize: 20),),
        subtitle: Text(product.price.toString(), style: const TextStyle(color: Colors.grey),),
        leading: CircleAvatar
        (
          backgroundImage: 
          product.image != null ?
            NetworkImage(product.image!)
          :
            null,
        ),
        trailing: BlocProvider
        (
          create: (context) => QuantityCubit(),
          child: QuantitySelector
          (
            onQuantityChanged: (quantity) 
            {
              onQuantityChanged(quantity);
            },
          ),
        ),
      ),
    );
  }
}