
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanshopai/Cubits/Company/Represntatives%20Cubit/representatives_cubit.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/Model/representative.dart';
import 'package:vanshopai/View/Company/representatativeinfo.dart';

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
          shadowColor: Colors.grey[100]!.withOpacity(.5),
          color: Colors.white,
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
                    onTap: ()
                    { BlocProvider.of<RepresentativesCubit>(context).updateRepresentativeSubmitted(representative.id);},
                    child: const Card(shape: CircleBorder(), color: Colors.white, child: Icon(Icons.check_circle, color: Color.fromARGB(255, 8, 87, 206), size: 32,)),
                  ),
        
                  // ! in case of rejecting the request, we have to send notification to the 
                  const InkWell
                  (
                    child: Card(shape: CircleBorder(), color: Colors.white, child: Icon(Icons.cancel, color: Color.fromARGB(255, 204, 15, 15), size: 32,)),
                  )
                ],
              ),
          ),
        ),
      ),
    );
  }
}