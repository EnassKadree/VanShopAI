import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Features/Stores/Controller/Get%20Stores%20Cubit/get_stores_cubit.dart';
import 'package:vanshopai/Features/Core/Helper/text.dart';
import 'package:vanshopai/Features/Core/Helper/constants.dart';

import '../Components/recommendedstoresbuilder.dart';

class AddRepStorePage extends StatelessWidget 
{
  const AddRepStorePage({super.key});

  @override
  Widget build(BuildContext context) 
  {
    final cubit = BlocProvider.of<GetStoresCubit>(context);
    cubit.getRecommendedStores(representativeConst);
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
            titleText('إضافة متاجر جديدة', fontSize: 32),
            BlocBuilder<GetStoresCubit, GetStoresState>
            (
              builder: (context, state)
              {
                return recommendedStoresBuilder(context, state, representativeConst);
              }
            )
          ],
        ),
      ),
    );
  }
}