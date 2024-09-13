
// import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:vanshopai/Model/representative.dart';

// class StoreRepCard extends StatelessWidget
// {
//   const StoreRepCard
//   ({
//     super.key,
//     required this.representative
//   });
//   final Representative representative;

//   @override
//   Widget build(BuildContext context) 
//   {
//     return Padding
//     (
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: InkWell
//       (
//         onTap: ()
//         {
//           //! navigateTo(context, RepresentativeInfo(rep: representative));
//         },
//         child: Card
//         (
//           color: Colors.white,
//           shadowColor: Colors.grey[100]!.withOpacity(.5),
//           child: ListTile
//           (
//             title: Text(representative.tradeName, style: TextStyle(color: Colors.blue[900], fontSize: 20),),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//             trailing: IconButton
//             (
//               icon: Icon(Iconsax.call,color: Colors.blue[600],size: 28) ,
//               onPressed: ()async {await FlutterPhoneDirectCaller.callNumber(representative.phone);},
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }