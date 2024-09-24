import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vanshopai/Features/Core/Helper/snackbar.dart';

class RepresentativeInfoCard extends StatelessWidget 
{
  const RepresentativeInfoCard({super.key, required this.data, required this.type});
  final String type;
  final String data;

  @override
  Widget build(BuildContext context) 
  {
    return Padding
    (
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: GestureDetector
      (
        onTap: () async
        {
          if(type == 'email')
          {await openMail(context);}
          else if(type == 'phone')
          {await FlutterPhoneDirectCaller.callNumber(data);}
        },
        child: Card
        (
          color: Colors.white,
          shadowColor: Colors.grey[100]!.withOpacity(.5),
          child: ListTile
          (
            title: Text
            (
              type == 'email' ?
                'البريد الإلكتروني'
              : type == 'phone' ?
                'رقم الهاتف'
              : type == 'country' ?
                'البلد'
              :
                'المحافظة', 
              style: TextStyle(fontSize: 12, color: Colors.blue[900]),
            ),
            subtitle: Text(data, style: const TextStyle(fontSize: 18, color: Colors.brown),),
            trailing: Icon
            (
              type == 'email' ?
                Iconsax.sms
              : type == 'phone' ?
                Iconsax.call 
              :
                null, 
              color: Colors.blue[600],size: 28,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openMail(BuildContext context) async 
  {
    final Uri emailUri = Uri
    (
      scheme: 'mailto',
      path: data, 
    );
    if (await canLaunchUrl(emailUri)) 
    {
      await launchUrl(emailUri);
    } else {
      showSnackBar(context, 'لا يمكن فتح البريد الإلكتروني المطلوب');
    }
  }
}