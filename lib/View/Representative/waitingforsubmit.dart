import 'package:flutter/material.dart';

class WaitingForSubmit extends StatelessWidget 
{
  const WaitingForSubmit({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return const Scaffold
    (
      body: Center
      (
        child: Text('لقد أرسلنا طلب مصادقة للشركة التي قمت باختيارها، يمكنك الوصول إلى حسابك بشكلٍ كامل عندما تتم الموافقة على طلب المصادقة'),
      ),
    );
  }
}