class TransactionItem {
  final int id;
  final String type;
  final double amount;
  final String description;
  final String status;
  final DateTime createdAt;
  final String? referenceNumber;
  final Map<String, dynamic>? metadata;

  TransactionItem({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.status,
    required this.createdAt,
    this.referenceNumber,
    this.metadata,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      id: json['id'],
      type: json['type'],
      amount: (json['amount'] as num).toDouble(),
      description: json['description'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      referenceNumber: json['reference_number'],
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'description': description,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'reference_number': referenceNumber,
      'metadata': metadata,
    };
  }
}
