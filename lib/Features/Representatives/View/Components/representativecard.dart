
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/Features/Representatives/Controller/representatives_cubit.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/Model/representative.dart';
import 'package:vanshopai/Features/Representatives/View/representatativeinfo.dart';

class RepresentativeCard extends StatelessWidget
{
  const RepresentativeCard
  ({
    super.key,
    required this.submitted,
    required this.representative
  });
  final bool submitted;
  final Representative representative;

  @override
  Widget build(BuildContext context) 
  {
    final cubit = BlocProvider.of<RepresentativesCubit>(context);
    return Padding
    (
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell
      (
        onTap: ()
        {
          navigateTo(context, RepresentativeInfo(rep: representative));
        },
        child: Card
        (
          color: Colors.white,
          shadowColor: Colors.grey[100]!.withOpacity(.5),
          child: ListTile
          (
            title: Text(representative.tradeName, style: TextStyle(color: Colors.blue[900], fontSize: 20),),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            trailing: 
            submitted?
              Text(representative.province, style: const TextStyle(color: Colors.grey),)
            :
              Row
              (
                mainAxisSize: MainAxisSize.min,
                children: 
                [
                  InkWell
                  (
                    onTap: () => cubit.updateRepresentativeSubmitted(representative.id),
                    child: const Card(shape: CircleBorder(), color: Colors.white, child: Icon(Iconsax.tick_circle, color: Color.fromARGB(255, 8, 87, 206), size: 32,)),
                  ),
        
                  InkWell
                  (
                    onTap: () => cubit.updateRepresentativeRejected(representative.id),
                    child: const Card(shape: CircleBorder(), color: Colors.white, child: Icon(Iconsax.close_circle, color: Color.fromARGB(255, 204, 15, 15), size: 32,)),
                  )
                ],
              ),
          ),
        ),
      ),
    );
  }
}