import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Company/cubit/products_cubit.dart';
import 'package:vanshopai/Widgets/productcard.dart';
import 'package:vanshopai/Widgets/progressindicator.dart';

class ArchivedCompanyProducts extends StatelessWidget
{
  const ArchivedCompanyProducts({super.key});

  @override
  Widget build(BuildContext context) 
  {
    ProductsCubit cubit = BlocProvider.of<ProductsCubit>(context);
    cubit.getArchivedProducts();
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
            Text
            (
              'منتجات الشركة المؤرشفة',style: TextStyle
              (
                color: Colors.orange[700]!,
                fontSize: 32,
                fontWeight: FontWeight.bold),
              ),
            BlocBuilder<ProductsCubit,ProductsState>
            (
              builder: (context, state)
              {
                if(state is ProductsLoading)
                {
                  return const Column
                  (
                    children: 
                    [
                      SizedBox(height: 16,),
                      MyProgressIndicator(),
                    ],
                  );
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
                        const SizedBox(height: 16,),
                        const Text('تعذر تحميل المنتجات المؤشفة!', style: TextStyle(fontSize: 18, color: Colors.grey)),
                        const SizedBox(height: 32,),
                        TextButton
                        (
                          onPressed: ()
                          { cubit.getArchivedProducts(); }, 
                          child: Text('حاول مرة أخرى', style: TextStyle(color: Colors.orange[700]!),)
                        )
                      ],
                  ),);
                }
                else
                {
                  if(cubit.archivedProducts.isEmpty)
                  {
                    return const Column
                    (
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: 
                      [
                        SizedBox(height: 16,),
                        Center(child: Text('لا يوجد منتجات مؤرشفة بعد!', style: TextStyle(fontSize: 18, color: Colors.grey),)),
                      ],
                    );
                  }
                  else
                  {
                    return Expanded
                    (
                      child: GridView.builder
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
                          return ProductCard(product: cubit.archivedProducts[index]);
                        }
                      ),
                    );
                  }
                }
              }
            )
          ],
        ),
      )
    );
  }
}