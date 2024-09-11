import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../Controller/Quantity Cubit/quantity_cubit.dart';

class QuantitySelector extends StatelessWidget 
{
  const QuantitySelector({super.key, required this.onQuantityChanged});
  final ValueChanged<int> onQuantityChanged;

  @override
  Widget build(BuildContext context) 
  {
    return Row
    (
      mainAxisSize: MainAxisSize.min,
      children: 
      [
        IconButton
        (
          icon: const Icon(Iconsax.minus),
          onPressed: () 
          { 
            context.read<QuantityCubit>().decrement();
            onQuantityChanged(context.read<QuantityCubit>().state); //* I'm trying to notify the parent here
          },
        ),
        BlocBuilder<QuantityCubit, int>
        (
          builder: (context, quantity) 
          {
            return Text(quantity.toString(), style: const TextStyle(fontSize: 18),);
          },
        ),
        IconButton(
          icon: const Icon(Iconsax.add),
          onPressed: () 
          { 
            context.read<QuantityCubit>().increment();
            onQuantityChanged(context.read<QuantityCubit>().state); //* I'm trying to notify the parent here
          },
        ),
      ],
    );
  }
}