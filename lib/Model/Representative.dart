class Representative 
{
  late String? userId;
  late String? id;
  late String? companyId;
  late String tradeName;
  late String country;
  late String province;
  late bool submitted;
  late String? email;
  late String? phone;

  Representative
  ({
    required this.userId,
    required this.id,
    required this.companyId,
    required this.tradeName,
    required this.country,
    required this.province,
    required this.submitted,
    required this.email, 
    required this.phone
  });

  factory Representative.fromJson(Map<String, dynamic> json) 
  {
    return Representative
    (
      userId: json['user_id'],
      id: json['id'],
      companyId: json['company_id'] ,
      tradeName: json['trade_name'] ,
      country: json['country'] ,
      province: json['province'] ,
      submitted: json['submitted'] ,
      email: json['email'] ,
      phone: json['phone'],
    );
  }
}
