class Product 
{
  late String id;
  late String? companyId;
  late String? distributorId;
  late String name;
  late String description;
  late String? image;
  late double price;
  late bool archived;

  Product({
    required this.id,
    this.companyId,
    this.distributorId,
    required this.name,
    required this.description,
    required this.price,
    this.archived = false,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      companyId: json['company_id'],
      distributorId: json['distributor_id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      archived: json['archived'] ?? false,
      image: json['image'],
    );
  }
}
