import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/View/General%20Widgets/customfloatingactionbutton.dart';
import 'package:vanshopai/View/Representative/addorderpage.dart';
import 'package:vanshopai/View/Representative/repdoneorders.dart';
import 'package:vanshopai/View/Representative/repprofile.dart';
import 'package:vanshopai/View/Representative/repunsubmittedpage.dart';
import 'package:vanshopai/sharedprefsUtils.dart';

import '../../Cubits/Bottom Nav Cubit/bottom_nav_cubit.dart';
import 'repincomingorders.dart';
import 'repstores.dart';

class RepresentativeHome extends StatelessWidget {
  const RepresentativeHome({super.key});

  final List<Widget> _pages = const [
    RepProfile(),
    RepIncomingOrdersPage(),
    AddRepOrderPage(),
    RepDoneOrdersPage(),
    RepStores(),
  ];

  @override
  Widget build(BuildContext context) 
  {
    if (prefs.getBool('submitted')!) 
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
                    icon: Icon(Iconsax.direct_inbox),
                    label: 'الوارد',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Iconsax.add,
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