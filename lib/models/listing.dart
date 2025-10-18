class Listing {
  final int? id;
  final String name;
  final double price;
  final String status;
  final String desc;

  get priceFixed => price.toStringAsFixed(2);

  Listing({
    this.id,
    required this.name,
    required this.price,
    this.status = "listed",
    required this.desc,
  });

  static Listing toObject(Map<String, Object?> map) {
    return Listing(
      id: map['id'] as int,
      name: map['name'] as String,
      price: map['price'] as double,
      status: map['status'] as String,
      desc: map['desc'] as String,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'status': status,
      'desc': desc,
    };
  }

  Listing copyWith({
    int? id,
    String? name,
    double? price,
    String? status,
    String? desc,
  }) {
    return Listing(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      status: status ?? this.status,
      desc: desc ?? this.desc,
    );
  }

  @override
  String toString() {
    return 'Listing{id: $id, name: $name, price: $price, status: $status, desc: $desc}';
  }
}
