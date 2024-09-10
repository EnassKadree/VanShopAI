
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/Cubits/Company/Products%20Cubit/products_cubit.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/Helper/snackbar.dart';
import 'package:vanshopai/Model/product.dart';
import 'package:vanshopai/View/Company/updateproduct.dart';

class ProductCard extends StatelessWidget 
{
  const ProductCard({
    required this.product,
    required this.sender,
    super.key,
  });

  final Product product;
  final String sender;
  @override
  Widget build(BuildContext context) 
  {
    ProductsCubit cubit = BlocProvider.of<ProductsCubit>(context);
    return GestureDetector
    (
      onLongPress: () 
      {
        showDialog(
            context: context,
            builder: (context) 
            {
              return DeleteAlertDialog(product: product, sender: sender);
            });
      },
      onTap: () 
      {
        navigateTo(context, UpdateProductPage(product: product, sender: sender,));
      },
      child: Column
      (
        children: 
        [
          Card
          (
            color:  const Color.fromARGB(255, 255, 251, 251),
            shape: RoundedRectangleBorder
            (
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding
            (
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: 
                [
                  Row
                  (
                    children: 
                    [
                      Expanded
                      (
                        child: Center
                        (
                          child: product.image != null?
                            ClipRRect
                            (
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network
                              (
                                product.image!,
                                fit: BoxFit.cover,
                                height: 135,
                                width: 135
                              ),
                            )
                          :
                            SizedBox
                            (
                              height: 135,
                              width: 135,
                              child: Icon(Iconsax.gallery, size: 100,color: Colors.brown[300],)
                            )
                        ),
                      ),
                    ],
                  ),
                  Text(
                    product.name,
                    style: TextStyle
                    (
                      color: Colors.orange[700],
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
                          fontSize: 16, color: Colors.brown
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          cubit.archiveProduct(product, context, sender);
                        },
                        child: Icon(
                          product.archived ? Iconsax.archive_minus : Iconsax.archive_add,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
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
    required this.product,
    required this.sender,
  });

  final Product product;
  final String sender;

  @override
  Widget build(BuildContext context) 
  {
    final cubit = BlocProvider.of<ProductsCubit>(context);
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
                cubit.deleteProduct(product.id!, sender);
              },
            ),
          ],
        );
      },
    );
  }
}
