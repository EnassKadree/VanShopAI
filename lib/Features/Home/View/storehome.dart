import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/Features/Orders/View/Get%20Orders/storedoneorders.dart';
import 'package:vanshopai/Features/Orders/View/Get%20Orders/storeincomingorders.dart';
import 'package:vanshopai/Features/Products/View/Get%20Products/productsearch.dart';

import '../../../Components/customfloatingactionbutton.dart';
import '../../Profiles/View/storeprofile.dart';
import '../../Representatives/View/storedists.dart';
import '../Controller/bottom_nav_cubit.dart';

class StoreHome extends StatelessWidget {
  const StoreHome({super.key});

  final List<Widget> _pages = const 
  [
    StoreProfile(),
    ProductSearch(),
    StoreDists(),
    StoreIncomingOrdersPage(),
    StoreDoneOrdersPage(),
  ];

  @override
  Widget build(BuildContext context) 
  {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: Scaffold(
        floatingActionButton: const CustomFloatingActionButton(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
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
                  icon: Icon(Iconsax.box4, color: Colors.transparent,),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.truck_fast),
                  label: 'الجاري',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.task_square),
                  label: 'المستلم',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}