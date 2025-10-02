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

  Listing toObject(Map<String, dynamic> map) {
    return Listing(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      status: map['status'],
      desc: map['desc'],
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
