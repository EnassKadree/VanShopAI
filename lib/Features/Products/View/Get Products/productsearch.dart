import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Components/progressindicator.dart';
import 'package:vanshopai/Features/Core/Helper/text.dart';

import '../../../Core/Model/product.dart';
import '../../Controller/Search Products/product_search_cubit.dart';
import '../Components/searchproductcard.dart';
import '../Components/searchtextfield.dart';

class ProductSearch extends StatelessWidget 
{
  const ProductSearch({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Padding
      (
        padding: const EdgeInsets.all(16.0),
        child: ListView
        (
          children: 
          [
            TitleText('ابحث عن منتج', fontSize: 32),
            const SizedBox(height: 20,),
            const SearchTextField(),
            
            const SizedBox(height: 20),
            
            BlocBuilder<ProductSearchCubit, ProductSearchState>
            (
              builder: (context, state) 
              {
                if (state is ProductSearchLoading) 
                {
                  return const Column(children: [SizedBox(height: 32,), MyProgressIndicator()],);
                } else if (state is ProductSearchSuccess) 
                {
                  return ListView.builder
                  (
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) 
                    {
                      Product product = state.products[index];
                      String owner = state.owners[index];
                      
                      return SearchProductCard(product: product, owner: owner);
                    },
                  );
                } else if (state is ProductSearchFailure) 
                {
                  return Center(child: Text(state.error));
                }
                return Center
                (
                  child: Text('ابدأ البحث عن منتجات',style: TextStyle(color: Colors.brown[300], fontSize: 18),)
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
