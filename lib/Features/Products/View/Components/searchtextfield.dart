
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Controller/Search Products/product_search_cubit.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
  });


  @override
  Widget build(BuildContext context) 
  {
    final cubit = BlocProvider.of<ProductSearchCubit>(context);
    return TextField
    (
      onChanged: (value) 
      {
        if (value.isNotEmpty) 
        {
          cubit.searchProductsByName(value);
        }
      },
      decoration: InputDecoration
      (
        labelStyle: TextStyle(color: Colors.brown[400]!),
        labelText: 'أدخل اسم المنتج المطلوب',
        enabledBorder: OutlineInputBorder
        (
          borderSide: BorderSide( color: Colors.brown[400]!, width: 2)
        ),
        focusedBorder: OutlineInputBorder
        (
          borderSide: BorderSide( color: Colors.brown[400]!, width: 2)
        ),
      ),
    );
  }
}
