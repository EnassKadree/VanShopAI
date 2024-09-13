
class Distributor 
{
  late String id;
  late String tradeName;
  late String country;
  late String province;
  late String email;
  late String phone;
  // late List<Store>? stores;

  Distributor
  ({
    required this.id,
    required this.tradeName,
    required this.country,
    required this.province,
    required this.email, 
    required this.phone,
    // this.stores
  });

  factory Distributor.fromJson(Map<String, dynamic> json) 
  {
    return Distributor
    (
      id: json['id'],
      tradeName: json['trade_name'] ,
      country: json['country'] ,
      province: json['province'] ,
      email: json['email'] ,
      phone: json['phone'],
      // stores: json['stores']
    );
  }
}
