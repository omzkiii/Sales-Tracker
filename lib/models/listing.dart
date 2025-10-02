class Listing {
  final int id;
  final String name;
  final int price;
  final String status;
  final String desc;

  Listing({
    required this.id,
    required this.name,
    required this.price,
    required this.status,
    required this.desc,
  });

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
