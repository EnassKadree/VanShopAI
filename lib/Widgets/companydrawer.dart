// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/Helper/snackbar.dart';
import 'package:vanshopai/View/Auth/Login/login.dart';
import 'package:vanshopai/sharedprefsUtils.dart';


class CompanyDrawer extends StatelessWidget 
{
    const CompanyDrawer({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Drawer
    (
      width: MediaQuery.of(context).size.width/1.5,
      child: ListView
      (
        children:
        [
          Column
          (
            children: 
            [
              UserAccountsDrawerHeader
              (
                decoration: BoxDecoration
                (
                  color: Color.fromARGB(255, 5, 28, 62),
                ),
                accountName: Text
                (
                  prefs.getString('name').toString(), 
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange)),
                accountEmail: Text(prefs.getString('email').toString())
              ),
        
              ListTile
              (
                title: const Text("Home page"),
                leading: Icon( Icons.home, color: Colors.orange ),
                //onTap: () { Get.toNamed("/adminhome"); },
              ),

              ListTile
              (
                title: const Text("Logout"),
                leading:  Icon(Icons.logout_rounded, color: Colors.orange),
                onTap: () async
                {
                  try
                  {
                    await FirebaseAuth.instance.signOut();
                    prefs.clear();
                    navigateRemoveUntil(context, LoginPage());
                  }catch(e)
                  {
                    ShowSnackBar(context, 'لقد حصل خطأ ما! حاول مرة أخرى');
                  }
                },
              ),
            ],
          ),
      ]
      ),
    );
  }
}
