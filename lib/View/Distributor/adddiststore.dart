import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Representative/Get%20Stores%20Cubit/get_stores_cubit.dart';
import 'package:vanshopai/Helper/text.dart';
import 'package:vanshopai/constants.dart';

import '../Representative/Widgets/recommendedstoresbuilder.dart';

class AddDistStorePage extends StatelessWidget 
{
  const AddDistStorePage({super.key});

  @override
  Widget build(BuildContext context) 
  {
    final cubit = BlocProvider.of<GetStoresCubit>(context);
    cubit.getRecommendedStores(distributorsConst);

    return Scaffold
    (
      body: Padding
      (
        padding: const EdgeInsets.all(16),
        child: Column
        (
          children: 
          [
            const SizedBox(height: 24,),
            TitleText('إضافة متاجر جديدة', fontSize: 32),
            BlocBuilder<GetStoresCubit, GetStoresState>
            (
              builder: (context, state)
              {
                return recommendedStoresBuilder(context, state, distributorsConst);
              }
            )
          ],
        ),
      ),
    );
  }
}