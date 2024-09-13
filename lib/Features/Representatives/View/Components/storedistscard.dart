
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/Features/Orders/View/Add%20Order/addstoreorderpage.dart';
import 'package:vanshopai/Features/Core/Model/distributor.dart';
import 'package:vanshopai/Features/Core/Model/representative.dart';

import '../../../Core/Helper/navigators.dart';

class StoreDistCard extends StatelessWidget
{
  const StoreDistCard
  ({
    super.key,
    this.distributor, this.representative, this.companyName
  });
  final Distributor? distributor;
  final Representative? representative;
  final String? companyName;

  @override
  Widget build(BuildContext context) 
  {
    bool dist = distributor != null;
    String name = dist? distributor!.tradeName : representative!.tradeName;
    String phone = dist? distributor!.phone : representative!.phone;
    return Padding
    (
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell
      (
        onTap: ()
        {
          if(distributor != null)
          {
            navigateTo(context, AddStoreOrderPage(distributor: distributor,));
          }
          else
          {
            navigateTo(context, AddStoreOrderPage(representative: representative,));
          }
        },
        child: Card
        (
          color: Colors.white,
          shadowColor: Colors.grey[100]!.withOpacity(.5),
          child: ListTile
          (
            title: Text(name, style: TextStyle(color: Colors.blue[900], fontSize: 20),),
            subtitle: dist? null : 
              Text(companyName ?? 'unknown', style: TextStyle(color: Colors.brown[400], fontSize: 16),),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            trailing: IconButton
            (
              icon: Icon(Iconsax.call,color: Colors.blue[600],size: 28) ,
              onPressed: ()async {await FlutterPhoneDirectCaller.callNumber(phone);},
            ),
          ),
        ),
      ),
    );
  }
}