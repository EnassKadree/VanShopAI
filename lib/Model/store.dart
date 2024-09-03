class Store 
{
  late String id;
  late String tradeName;
  late String province;
  late String address;
  late String email;
  late String phone;
  late String country;

  Store
  ({
    required this.id,
    required this.tradeName,
    required this.country,
    required this.province,
    required this.address,
    required this.email, 
    required this.phone
  });

  factory Store.fromJson(Map<String, dynamic> json) 
  {
    return Store
    (
      id: json['id'],
      tradeName: json['trade_name'] ,
      country: json['country'] ,
      province: json['province'] ,
      address: json['address'] ,
      email: json['email'] ,
      phone: json['phone'],
    );
  }
}
