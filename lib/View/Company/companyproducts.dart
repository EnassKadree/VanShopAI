import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Company/cubit/products_cubit.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/View/Company/addproduct.dart';
import 'package:vanshopai/View/Company/archivedcompanyproducts.dart';
import 'package:vanshopai/Widgets/productcard.dart';
import 'package:vanshopai/Widgets/progressindicator.dart';

class CompanyProducts extends StatelessWidget
{
  const CompanyProducts({super.key});

  @override
  Widget build(BuildContext context) 
  {
    ProductsCubit cubit = BlocProvider.of<ProductsCubit>(context);
    cubit.getProducts();
    return Scaffold
    (
      floatingActionButton: FloatingActionButton
      (
        onPressed: ()
        {
          navigateTo(context, AddProductPage());
        },
        child: const Icon(Icons.add)
      ),
      body: Padding
      (
        padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 16),
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: 
          [
            TextButton
            (
              onPressed: ()
              {
                navigateTo(context, const ArchivedCompanyProducts());
              },
              child: const Row
              (
                children: 
                [
                  Icon(Icons.archive, size: 16, color: Colors.grey,),
                  SizedBox(width: 12,),
                  Text('المنتجات المؤرشفة', style: TextStyle(fontSize: 16, color: Colors.grey),),
                ],
              ),
            ),
            Text
            (
              'منتجات الشركة',style: TextStyle
              (
                color: Colors.orange[700]!,
                fontSize: 36,
                fontWeight: FontWeight.bold),
              ),
            BlocBuilder<ProductsCubit,ProductsState>
            (
              builder: (context, state)
              {
                if(state is ProductsLoading)
                {
                  return const Column(
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
                        const Text('تعذر تحميل المنتجات!', style: TextStyle(fontSize: 18, color: Colors.grey)),
                        const SizedBox(height: 32,),
                        TextButton
                        (
                          onPressed: ()
                          { cubit.getProducts(); }, 
                          child: Text('حاول مرة أخرى', style: TextStyle(color: Colors.orange[700]!),)
                        )
                      ],
                  ),);
                }
                else
                {
                  if(cubit.products.isEmpty)
                  {
                    return const Column
                    (
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: 
                      [
                        SizedBox(height: 16,),
                        Center(child: Text('لا يوجد منتجات بعد!', style: TextStyle(fontSize: 18, color: Colors.grey),)),
                      ],
                    );
                  }
                  else
                  {
                    return Expanded
                    (
                      child: GridView.builder
                      (
                        itemCount: cubit.products.length,
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
                          return ProductCard(product: cubit.products[index]);
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