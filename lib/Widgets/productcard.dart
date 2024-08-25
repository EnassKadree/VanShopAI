// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Company/cubit/products_cubit.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/Helper/snackbar.dart';
import 'package:vanshopai/Model/product.dart';
import 'package:vanshopai/View/Company/updateproduct.dart';
import 'package:vanshopai/constants.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    required this.product,
    super.key,
  });

  Product product;
  @override
  Widget build(BuildContext context) {
    ProductsCubit cubit = BlocProvider.of<ProductsCubit>(context);
    return GestureDetector
    (
      onLongPress: () 
      {
        showDialog(
            context: context,
            builder: (context) 
            {
              return DeleteAlertDialog(cubit: cubit, product: product);
            });
      },
      onTap: () {
        navigateTo(context, UpdateProductPage(product: product));
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 50,
                color: Colors.grey.withOpacity(.1),
                spreadRadius: 20,
                offset: const Offset(10, 10),
              ),
            ]),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 10,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Center(
                            child: Image.asset(
                          productImage,
                          height: 120,
                        )),
                      ],
                    ),
                    Text(
                      product.name,
                      style: TextStyle(
                        color: Colors.orange[700],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          r'$' '${product.price.toString()}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            cubit.archiveProduct(product, context);
                          },
                          child: Icon(
                            product.archived ? Icons.unarchive : Icons.archive,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DeleteAlertDialog extends StatelessWidget 
{
  const DeleteAlertDialog({
    super.key,
    required this.cubit,
    required this.product,
  });

  final ProductsCubit cubit;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>
    (
      listener: (context, state)
      {
        if(state is DeleteProductFailure)
        { ShowSnackBar(context, 'حصل خطأ ما! لم يتم حذف المنتج، حاول مرة أخرى');}
        else if(state is DeleteProductSuccess)
        { ShowSnackBar(context, 'تم حذف المنتج بنجاح'); pop(context);}
      },
      builder: (context, state) 
      {
        return AlertDialog
        (
          title: const Text
          (
            'حذف المنتج',
            style: TextStyle(color: Colors.orange),
          ),
          content: state is DeleteProductLoading? 
            const Text('جارٍ حذف المنتج...')
            : const Text('هل أنت متأكد من حذف هذا المنتج؟'),
          actions: 
          [
            TextButton
            (
              child: const Text('إلغاء'),
              onPressed: () 
              {
                pop(context);
              },
            ),
            TextButton
            (
              child: const Text(
                'حذف',
                style: TextStyle(color: Colors.orange),
              ),
              onPressed: () async 
              {
                cubit.deleteProduct(product.id!);
              },
            ),
          ],
        );
      },
    );
  }
}
