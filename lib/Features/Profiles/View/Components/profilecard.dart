
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget 
{
  const ProfileCard({
    super.key, required this.title, required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) 
  {
    return Padding
    (
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card
      (
        color: Colors.white,
        elevation: .5,
        child: ListTile
        (
          title: Text
          (
            title, 
            style: TextStyle(fontSize: 12, color: Colors.blue[900]),
          ),
          subtitle: Text(subtitle, style: const TextStyle(fontSize: 18, color: Colors.brown),),
        ),
      ),
    );
  }
}
