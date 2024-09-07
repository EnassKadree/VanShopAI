import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vanshopai/Helper/snackbar.dart';

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
          elevation: .5,
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
              style: TextStyle(fontSize: 12, color: Colors.blue[600]),
            ),
            subtitle: Text(data, style: const TextStyle(fontSize: 18),),
            trailing: Icon
            (
              type == 'email' ?
                Icons.mail_outline_outlined
              : type == 'phone' ?
                Icons.call_outlined 
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
      ShowSnackBar(context, 'لا يمكن فتح البريد الإلكتروني المطلوب');
    }
  }
}