import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel 
{
  late String? id;
  late String? representativeId;
  late String? distributorId;
  late String storeId;
  late List<Map<String, dynamic>> products;
  late String status;
  DateTime? createdAt;

  OrderModel
  ({
    this.id,
    this.representativeId,
    this.distributorId,
    required this.storeId,
    required this.products,
    required this.status,
    this.createdAt
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) 
  {
    return OrderModel
    (
      id: json['id'],
      distributorId: json['distributor_id'],
      representativeId: json['representative_id'],
      storeId: json['store_id'],
      products: List<Map<String, dynamic>>.from(json['products']),
      status:  json['status'],
      createdAt: json['created_at'].toDate()
    );
  }

  Map<String, dynamic> toJson() 
  {
    return 
    {
      'products': products,
      'distributor_id': distributorId,
      'representative_id' : representativeId,
      'store_id' : storeId,
      'status' : status,
      'created_at': FieldValue.serverTimestamp(),
    };
  }
}
