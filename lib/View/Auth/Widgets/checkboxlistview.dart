// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Auth/Categories%20Cubit/categories_cubit.dart';

class CheckBoxListView extends StatelessWidget 
{
  CheckBoxListView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CategoriesCubit>(context);
    return Expanded(child: BlocBuilder<CategoriesCubit, CategoriesState>
    (
      builder: (context, state) 
      {
        return ListView.builder
        (
          itemCount: cubit.categories.length,
          itemBuilder: ((context, index) 
          {
            final category = cubit.categories[index];
            final isSelected = cubit.selectedCategories.contains(category);

            return Column
            (
              children: 
              [
                CheckboxListTile
                (
                  title: Text(cubit.categories[index]),
                  value: isSelected,
                  onChanged: (value) 
                  {
                    cubit.toggleCategorySelection(category, isSelected);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Divider(thickness: .4),
                )
              ],
            );
          }),
        );
      },
    ));
  }
}
