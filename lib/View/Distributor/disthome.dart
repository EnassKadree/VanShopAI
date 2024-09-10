import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/View/Distributor/distproducts.dart';
import 'package:vanshopai/View/Distributor/distprofile.dart';

import '../../Cubits/Bottom Nav Cubit/bottom_nav_cubit.dart';

class DistributorHome extends StatelessWidget {
  const DistributorHome({super.key});

  final List<Widget> _pages = const 
  [
    DistProfile(),
    DistProducts(),
    DistProfile(),
    DistProfile(),
    DistProfile(),
    DistProfile(),
  ];

  @override
  Widget build(BuildContext context) 
  {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: Scaffold(
        body: BlocBuilder<BottomNavCubit, int>
        (
          builder: (context, state) {
            return _pages[state];
          },
        ),
        bottomNavigationBar: BlocBuilder<BottomNavCubit, int>
        (
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: state,
              onTap: (index) =>
                  context.read<BottomNavCubit>().updateTab(index),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.profile_circle),
                  label: 'الحساب',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.box4),
                  label: 'المنتجات',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.direct_inbox),
                  label: 'الوارد',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.direct_send),
                  label: 'المستلم',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.shop),
                  label: 'زبائني',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}