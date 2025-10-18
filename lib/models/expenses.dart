class Expense {
  int? id;
  final int listingId;
  final String name;
  final double amount;
  final String desc;

  get amountFixed => amount.toStringAsFixed(2);

  Expense({
    this.id,
    required this.listingId,
    required this.name,
    required this.amount,
    required this.desc,
  });

  static Expense toObject(Map<String, Object?> map) {
    return Expense(
      id: map['id'] as int,
      listingId: map['listing_id'] as int,
      name: map['name'] as String,
      amount: map['amount'] as double,
      desc: map['desc'] as String,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'listing_id': listingId,
      'name': name,
      'amount': amount,
      'desc': desc,
    };
  }

  @override
  String toString() {
    return 'Expense{id: $id, listingId: $listingId, name: $name, amount: $amount, desc: $desc}';
  }
}
