import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/Features/Home/Controller/bottom_nav_cubit.dart';
import 'package:vanshopai/Features/Products/View/Add%20&%20Update%20Product/addcompanyproduct.dart';
import 'package:vanshopai/Features/Products/View/Get%20Products/companyproducts.dart';
import 'package:vanshopai/Features/Profiles/View/companyprofile.dart';
import 'package:vanshopai/Features/Representatives/View/companyrepresentatives.dart';
import 'package:vanshopai/Features/Representatives/View/companyrequests.dart';

import '../../../Components/customfloatingactionbutton.dart';


class CompanyHome extends StatelessWidget 
{
  const CompanyHome({super.key});

  final List<Widget> _pages = const 
  [
    CompanyProfile(),
    CompanyProducts(),
    AddCompanyProductPage(),
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
