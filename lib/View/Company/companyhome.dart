import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/Cubits/Bottom%20Nav%20Cubit/bottom_nav_cubit.dart';
import 'package:vanshopai/View/Company/addproduct.dart';
import 'package:vanshopai/View/Company/companyproducts.dart';
import 'package:vanshopai/View/Company/companyprofile.dart';
import 'package:vanshopai/View/Company/companyrepresentatives.dart';
import 'package:vanshopai/View/Company/companyrequests.dart';

import '../General Widgets/customfloatingactionbutton.dart';


class CompanyHome extends StatelessWidget 
{
  const CompanyHome({super.key});

  final List<Widget> _pages = const 
  [
    CompanyProfile(),
    CompanyProducts(),
    AddProductPage(),
    CompanyRequests(),
    CompanyRepresentatives(),
  ];

  @override
  Widget build(BuildContext context) 
  {
    return BlocProvider
    (
      create: (context) => BottomNavCubit(),
      child: Scaffold
      (
        floatingActionButton: BlocBuilder<BottomNavCubit, int>
        (
          builder: (context, state) 
          {
            return const CustomFloatingActionButton();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body:  BlocBuilder<BottomNavCubit, int>
        (
          builder: (context, state) 
          {
            return _pages[state];
          },
        ),
        bottomNavigationBar: BlocBuilder<BottomNavCubit, int>
        (
          builder: (context, state) 
          {
            return BottomNavigationBar
            (
              currentIndex: state,
              onTap: (index) =>
                  context.read<BottomNavCubit>().updateTab(index),
              items: const 
              [
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.profile_circle),
                  label: 'الحساب',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.box4),
                  label: 'المنتجات',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.box4, color: Colors.white),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.user_add),
                  label: 'الطلبات',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.profile_2user),
                  label: 'المندوبين',
                ),
              ],
            );
          }
        )
      ),
    );
  }
}
