
class Representative 
{
  late String id;
  late String companyId;
  late String tradeName;
  late String country;
  late String province;
  late bool submitted;
  late bool rejected;
  late String email;
  late String phone;
  // late List<Store>? stores;

  Representative
  ({
    required this.id,
    required this.companyId,
    required this.tradeName,
    required this.country,
    required this.province,
    required this.submitted,
    required this.rejected,
    required this.email, 
    required this.phone,
    // this.stores
  });

  factory Representative.fromJson(Map<String, dynamic> json) 
  {
    return Representative
    (
      id: json['id'],
      companyId: json['company_id'] ,
      tradeName: json['trade_name'] ,
      country: json['country'] ,
      province: json['province'] ,
      submitted: json['submitted'] ,
      email: json['email'] ,
      phone: json['phone'],
      rejected: json['rejected']
      // stores: json['stores']
    );
  }
}
