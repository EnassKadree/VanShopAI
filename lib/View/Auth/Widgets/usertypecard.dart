
import 'package:flutter/material.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/View/Auth/Signup/companysingup.dart';
import 'package:vanshopai/View/Auth/Signup/distributorsignup.dart';
import 'package:vanshopai/View/Auth/Signup/representativesingup.dart';
import 'package:vanshopai/View/Auth/Signup/storesingup.dart';

class UserTypeCard extends StatelessWidget 
{
  const UserTypeCard
  ({
    super.key, required this.text
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell
    (
      onTap: ()
      {
        if(text == 'شركة أو مؤسسة تجارية') 
          {navigateTo(context, CompanySignupPage());} 
        else if(text == 'مندوب شركة')
          {navigateTo(context, RepresentativeSignupPage());}
        else if(text == 'موزع حر')
          {navigateTo(context, DistributorSignupPage());}
        else if(text == 'صاحب متجر')
        {navigateTo(context, StoreSignupPage());}
      },
      child: Card
      (
        color: Colors.white,
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Container
        (
          width: double.infinity,
          padding: const EdgeInsets.all( 24.0,),
          child: Center
          (
            child: Text
            (text, style:  const TextStyle(fontSize: 24,color: Colors.black54),),
          ),
        ),
      ),
    );
  }
}