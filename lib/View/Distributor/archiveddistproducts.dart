import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Company/Products%20Cubit/products_cubit.dart';
import 'package:vanshopai/Helper/text.dart';
import 'package:vanshopai/View/General%20Widgets/productcard.dart';
import 'package:vanshopai/View/General%20Widgets/progressindicator.dart';
import 'package:vanshopai/constants.dart';

class ArchivedDistProducts extends StatelessWidget
{
  const ArchivedDistProducts({super.key});

  @override
  Widget build(BuildContext context) 
  {
    ProductsCubit cubit = BlocProvider.of<ProductsCubit>(context);
    cubit.getProducts(archived: true, sender: distributorsConst);
    return Scaffold
    (
      body: Padding
      (
        padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 16),
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: 
          [
            TitleText
            (
              'المنتجات المؤرشفة',
              fontSize: 32
            ),
            Expanded
            (
              child: BlocBuilder<ProductsCubit,ProductsState>
              (
                builder: (context, state)
                {
                  if(state is ProductsLoading)
                  {
                    return const MyProgressIndicator();
                  }
                  else if(state is ProductsFailure)
                  {
                    return Center
                    (
                      child: Column
                      (
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: 
                        [
                          const Text('تعذر تحميل المنتجات المؤشفة!', style: TextStyle(fontSize: 18, color: Colors.grey)),
                          const SizedBox(height: 32,),
                          TextButton
                          (
                            onPressed: ()
                            { cubit.getProducts(archived: true, sender: distributorsConst); }, 
                            child: Text('حاول مرة أخرى', style: TextStyle(color: Colors.orange[700]!),)
                          )
                        ],
                    ),);
                  }
                  else
                  {
                    if(cubit.archivedProducts.isEmpty)
                    {
                      return const Center(child: Text('لا يوجد منتجات مؤرشفة بعد!', style: TextStyle(fontSize: 18, color: Colors.grey),));
                    }
                    else
                    {
                      return GridView.builder
                      (
                        itemCount: cubit.archivedProducts.length,
                        clipBehavior: Clip.none,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
                        (
                          crossAxisCount: 2,
                          childAspectRatio: .5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 100,
                        ),
                        itemBuilder: (context, index)
                        {
                          return ProductCard(product: cubit.archivedProducts[index], sender: distributorsConst,);
                        }
                      );
                    }
                  }
                }
              ),
            )
          ],
        ),
      )
    );
  }
}