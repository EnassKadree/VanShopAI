
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../Helper/navigators.dart';

class CustomFloatingActionButtonAdd extends StatelessWidget 
{
  const CustomFloatingActionButtonAdd({
    super.key, required this.label, required this.rout, this.heroTag
  });
  final String label;
  final Widget rout;
  final String? heroTag;

  @override
  Widget build(BuildContext context) 
  {
    return FloatingActionButton.extended
    (
      onPressed: () => navigateTo(context, rout),
      icon: Icon(Iconsax.add, color: Colors.white.withOpacity(.8)),
      label: Text(label, style: TextStyle(color: Colors.white.withOpacity(.8)),),
      backgroundColor: Colors.brown[400],
      heroTag: heroTag,
    );
  }
}