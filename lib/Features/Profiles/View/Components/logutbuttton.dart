
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../Core/Helper/navigators.dart';
import '../../../../Extensions/sharedprefsutils.dart';
import '../../../Auth/View/Login/login.dart';

class LogoutButton extends StatelessWidget 
{
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) 
  {
    return IconButton
    (
      onPressed: ()
      {
        showDialog
        (
          context: context, 
          builder: (context)
          {
            return AlertDialog
            (
              title: Text('تسجيل خروج', style: TextStyle(color: Colors.orange[700]),),
              content: const Text('هل أنت متأكد من تسجيل الخروج؟'),
              actions: 
              [
                TextButton
                (
                  onPressed: (){pop(context);}, 
                  child: const Text('لا')
                ),
                TextButton
                (
                  onPressed: () async
                  {
                    await FirebaseAuth.instance.signOut();
                    prefs.clear();
                    navigateRemoveUntil(context, const LoginPage());
                  }, 
                  child: Text('نعم',style: TextStyle(color: Colors.orange[700]),)
                ),
              ],
            );
          }
        );
      }, 
      icon: Icon(Iconsax.logout, color: Colors.brown[300], size: 28,)
    );
  }
}
