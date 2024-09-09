import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/View/Representative/addorderpage.dart';
import 'package:vanshopai/View/Representative/doneorders.dart';
import 'package:vanshopai/View/Representative/repprofile.dart';
import 'package:vanshopai/View/Representative/repunsubmittedpage.dart';
import 'package:vanshopai/sharedprefsUtils.dart';

import '../../Cubits/Bottom Nav Cubit/bottom_nav_cubit.dart';
import 'incomingorders.dart';
import 'representativestores.dart';

class RepresentativeHome extends StatelessWidget {
  const RepresentativeHome({super.key});

  final List<Widget> _pages = const [
    RepProfile(),
    IncomingOrdersPage(),
    AddRepOrderPage(),
    DoneOrdersPage(),
    RepresentativeStores(),
  ];

  @override
  Widget build(BuildContext context) {
    if (prefs.getBool('submitted')!) {
      return BlocProvider(
        create: (context) => BottomNavCubit(),
        child: Scaffold(
          floatingActionButton: BlocBuilder<BottomNavCubit, int>
          (
            builder: (context, state) 
            {
              return FloatingActionButton
              (
                heroTag: 'fab_rep_home',
                onPressed: () 
                {
                  context.read<BottomNavCubit>().updateTab(2);
                },
                backgroundColor: Colors.brown,
                shape: const CircleBorder(),
                child: Icon(Iconsax.add, color: Colors.grey[100], size: 28,),
              );
            },
          ),
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
                elevation: 5,
                currentIndex: state,
                onTap: (index) =>
                    context.read<BottomNavCubit>().updateTab(index),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.profile_circle),
                    label: 'الحساب',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.direct_inbox),
                    label: 'الوارد',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.inbox,
                      color: Colors.white,
                    ),
                    label: '',
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
    } else {
      return const RepUnSubmittedPage();
    }
  }
}