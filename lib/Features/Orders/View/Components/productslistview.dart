
import 'package:flutter/material.dart';

import '../../../Products/Controller/Get Products Cubit/get_products_cubit.dart';
import 'repproductcard.dart';

class ProductsListView extends StatelessWidget 
{
  const ProductsListView({
    super.key,
    required this.cubit,
    required this.selectedProducts
  });

  final GetProductsCubit cubit;
  final selectedProducts;

  @override
  Widget build(BuildContext context) 
  {
    return ListView.builder
    (
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cubit.products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: cubit.products[index],
          onQuantityChanged: (quantity) 
          {
            selectedProducts[cubit.products[index].id] =  quantity; //*  I'm Tracking quantity for each product
          },
        );
      }
    );
  }
}
