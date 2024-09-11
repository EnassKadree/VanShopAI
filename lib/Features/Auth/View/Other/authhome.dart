import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/Features/Auth/View/Signup/companysingup.dart';
import 'package:vanshopai/Features/Auth/View/Signup/distributorsignup.dart';
import 'package:vanshopai/Features/Auth/View/Signup/representativesingup.dart';
import 'package:vanshopai/Features/Auth/View/Signup/storesingup.dart';


import '../../../Home/Controller/bottom_nav_cubit.dart';


class AuthHomePage extends StatelessWidget 
{
  const AuthHomePage({super.key});

  final List<Widget> _pages = const 
  [
    CompanySignupPage(),
    RepresentativeSignupPage(),
    DistributorSignupPage(),
    StoreSignupPage(),
  ];

  @override
  Widget build(BuildContext context) 
  {
    return BlocProvider(
      create: (context) => BottomNavCubit(init: 0),
      child: Scaffold
      (
        body: BlocBuilder<BottomNavCubit, int>
        (
          builder: (context, state) {
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
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.building),
                  label: 'شركة',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.user_tag),
                  label: 'مندوب',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Iconsax.user,
                  ),
                  label: 'موزع',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.shop),
                  label: 'متجر',
                ),
              ],
            );
          },
        ),
      ),
    );
    
  }
}