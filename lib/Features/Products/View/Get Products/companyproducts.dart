import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/Features/Products/Controller/Products%20Cubit/products_cubit.dart';
import 'package:vanshopai/Features/Core/Helper/navigators.dart';
import 'package:vanshopai/Features/Core/Helper/text.dart';
import 'package:vanshopai/Features/Products/View/Components/productcard.dart';
import 'package:vanshopai/Features/Products/View/Get%20Products/archivedcompanyproducts.dart';
import 'package:vanshopai/Components/progressindicator.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';

class CompanyProducts extends StatelessWidget
{
  const CompanyProducts({super.key});

  @override
  Widget build(BuildContext context) 
  {
    ProductsCubit cubit = BlocProvider.of<ProductsCubit>(context);
    cubit.getProducts(archived: false, sender: companiesConst);
    return Scaffold
    (
      body: Padding
      (
        padding: const EdgeInsets.all(16),
        child: ListView
        (
          children: 
          [
            titleText
            (
              'منتجات الشركة', 
              fontSize: 32
            ),
            const SizedBox(height: 16,),
            BlocBuilder<ProductsCubit,ProductsState>
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
                        const Text('تعذر تحميل المنتجات!', style: TextStyle(fontSize: 18, color: Colors.grey)),
                        const SizedBox(height: 32,),
                        TextButton
                        (
                          onPressed: ()
                          { cubit.getProducts(archived: false, sender: companiesConst); }, 
                          child: Text('حاول مرة أخرى', style: TextStyle(color: Colors.orange[700]!),)
                        )
                      ],
                  ),);
                }
                else
                {
                  if(cubit.products.isEmpty)
                  {
                    return const Center(child: Text('لا يوجد منتجات بعد!', style: TextStyle(fontSize: 18, color: Colors.grey),));
                  }
                  else
                  {
                    return GridView.builder
                    (
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cubit.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
                      (
                        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                        childAspectRatio: MediaQuery.of(context).size.width > 600 ? 0.85 : 0.82,
                      ),
                      itemBuilder: (context, index)
                      {
                        return ProductCard(product: cubit.products[index], sender: companiesConst,);
                      }
                    );
                  }
                }
              }
            ),
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
                  Icon(Iconsax.folder, size: 18, color: Colors.grey,),
                  SizedBox(width: 12,),
                  Text('المنتجات المؤرشفة', style: TextStyle(fontSize: 16, color: Colors.grey),),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}