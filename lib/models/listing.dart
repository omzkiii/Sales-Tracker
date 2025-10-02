class Listing {
  final int id;
  final String name;
  final double price;
  final String status;
  final String desc;

  Listing({
    required this.id,
    required this.name,
    required this.price,
    required this.status,
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
      'age': price,
      'status': status,
      'desc': desc,
    };
  }

  @override
  String toString() {
    return 'Listing{id: $id, name: $name, age: $price, status: $status, desc: $desc}';
  }
}
