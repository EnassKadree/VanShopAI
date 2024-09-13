
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Products/Controller/Get Products Cubit/get_products_cubit.dart';
import '../../../../Components/progressindicator.dart';
import 'productslistview.dart';

productsBuilder(context, state, selectedProducts, productsOwner, ownerId)
{
  final cubit = BlocProvider.of<GetProductsCubit>(context);
  if (state is GetProductsLoading) 
  {
    return const MyProgressIndicator();
  } else if (state is GetProductsFailure) 
  {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('تعذر تحميل المنتجات!',
              style: TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(
            height: 32,
          ),
          TextButton(
              onPressed: () {
                cubit.getProducts(productsOwner, ownerId);
              },
              child: Text(
                'حاول مرة أخرى',
                style: TextStyle(color: Colors.orange[700]!),
              ))
        ],
      ),
    );
  } else {
    if (cubit.products.isEmpty) 
    {
      return const Center(
          child: Text(
        'لا يوجد أي منتجات متاحة!',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ));
    } else 
    {
      return ProductsListView(cubit: cubit, selectedProducts: selectedProducts);
    }
  }
}