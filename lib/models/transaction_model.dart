class TransactionModel {
  final String amount;
  final String sender_id;
  final String reciever_id;
  final String time;
  TransactionModel({
    required this.amount,
    required this.sender_id,
    required this.reciever_id,
    required this.time,
  });

  // Factory constructor to create a TransactionModel instance from a map
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      amount: json['amount'] ?? '',
      sender_id: json['sender_id'] ?? '',
      reciever_id: json['reciever_id'] ?? '',
      time: json['time'] ?? '',
    );
  }

  // Method to convert a TransactionModel instance to a map
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'sender_id': sender_id,
      'reciever_id': reciever_id,
      'time': time,
    };
  }
}
