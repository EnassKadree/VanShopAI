
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../Features/Home/Controller/bottom_nav_cubit.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton
    (
      onPressed: () 
      {
        context.read<BottomNavCubit>().updateTab(2);
      },
      backgroundColor: Colors.brown,
      shape: const CircleBorder(),
      child: Icon(Iconsax.add, color: Colors.grey[100], size: 28,),
    );
  }
}
