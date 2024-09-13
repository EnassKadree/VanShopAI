
import 'package:flutter/material.dart';

import '../../../Core/Model/product.dart';

class SearchProductCard extends StatelessWidget {
  const SearchProductCard({
    super.key,
    required this.product,
    required this.owner,
  });

  final Product product;
  final String owner;

  @override
  Widget build(BuildContext context) {
    return Card
    (
      color: Colors.white,
      shadowColor: Colors.grey[100]!.withOpacity(.5),
      child: ListTile
      (
        title: Text(product.name, style: TextStyle(color: Colors.blue[900], fontSize: 20),),
        subtitle: Column
        (
          children: 
          [
            Row
            (
              children: 
              [
                Text('موجود لدى:   ', style: TextStyle(color: Colors.brown[400]),),
                Text(owner)
              ],
            ),
            Row
            (
              children: 
              [
                Text('السعر:   ', style: TextStyle(color: Colors.brown[400]),),
                Text('${product.price}')
              ],
            ),
          ],
        ),
        //isThreeLine: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
        leading: CircleAvatar
        (
          backgroundImage: 
          product.image == null? null :
          NetworkImage(product.image!)
        ),
      ),
    );
  }
}
