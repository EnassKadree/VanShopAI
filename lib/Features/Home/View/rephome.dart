import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/Components/customfloatingactionbutton.dart';
import 'package:vanshopai/Features/Orders/View/Add%20Order/addreporderpage.dart';
import 'package:vanshopai/Features/Orders/View/Get%20Orders/repdoneorders.dart';
import 'package:vanshopai/Features/Profiles/View/repprofile.dart';
import 'package:vanshopai/Features/Home/View/repunsubmittedpage.dart';
import 'package:vanshopai/Extensions/sharedprefsutils.dart';

import '../Controller/bottom_nav_cubit.dart';
import '../../Orders/View/Get Orders/repincomingorders.dart';
import '../../Stores/View/Get Stores/repstores.dart';

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