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
  late String storeName;

  // this list is just used to make sure not to lose data when refetching order data
  List<Map<String, dynamic>>? originalProducts;

  OrderModel
  ({
    this.id,
    this.representativeId,
    this.distributorId,
    required this.storeId,
    required this.products,
    required this.status,
    this.createdAt,
    required this.storeName,

    this.originalProducts
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
      createdAt: json['created_at'].toDate(),
      storeName: json['store_name']
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
      'store_name': storeName
    };
  }
}
