import 'package:firebase_auth/firebase_auth.dart';
import 'package:xpanse_app/controllers/auth_controller.dart';
import 'package:xpanse_app/utils/parseMomo.dart';

enum TransactionType { RECEIVED, SENT }

class MoMoTransaction {
  final TransactionType type;
  final String? userId;
  final int amount;
  final DateTime timestamp;
  final int balance;
  final String currency;
  final String? docId;
  final int? fee; // Only for sent transactions

  // For received transactions
  final String? senderName;
  final String? senderPhone;
  final String? transactionId;

  // For sent transactions
  final String? recipientName;
  final String? recipientPhone;
  final String? senderId;

  final String? category;

  MoMoTransaction({
    required this.type,
    required this.amount,
    required this.timestamp,
    required this.balance,
    required this.currency,
    required this.userId,
    this.fee,
    this.senderName,
    this.senderPhone,
    this.transactionId,
    this.recipientName,
    this.recipientPhone,
    this.senderId,
    this.docId,
    this.category,
  });

  factory MoMoTransaction.fromMessage(String message) {
    final parsed = parseMobileMoneyMessage(message);

    if (!parsed['isValid']) {
      throw Exception('Failed to parse message: ${parsed['error']}');
    }

    if (parsed['type'] == 'SENT') {
      return MoMoTransaction(
        type: TransactionType.SENT,
        amount: parsed['amount'] ?? 0,
        timestamp: parsed['timestamp'] ?? DateTime.now(),
        balance: parsed['balance'] ?? 0,
        currency: parsed['currency'] ?? 'RWF',
        fee: parsed['fee'],
        recipientName: parsed['recipient']?['name'],
        recipientPhone: parsed['recipient']?['phone'],
        senderId: parsed['senderId'],
        userId: AuthService.currentUser!.uid,
      );
    } else {
      return MoMoTransaction(
        type: TransactionType.RECEIVED,
        amount: parsed['amount'] ?? 0,
        timestamp: parsed['timestamp'] ?? DateTime.now(),
        balance: parsed['balance'] ?? 0,
        currency: parsed['currency'] ?? 'RWF',
        senderName: parsed['sender']?['name'],
        senderPhone: parsed['sender']?['phone'],
        transactionId: parsed['transactionId'],
        userId: AuthService.currentUser!.uid,
      );
    }
  }

  // Helper methods
  bool isReceived() => type == TransactionType.RECEIVED;
  bool isSent() => type == TransactionType.SENT;

  int get totalAmount => amount + (fee ?? 0);

  @override
  String toString() {
    if (isReceived()) {
      return '''
       Received Transaction:
       Amount: $amount $currency
       From: $senderName ($senderPhone)
       Transaction ID: $transactionId
       Time: $timestamp
       Balance: $balance $currency
       Doc ID: $docId
     ''';
    } else {
      return '''
       Sent Transaction:
       Amount: $amount $currency
       To: $recipientName ($recipientPhone)
       Fee: ${fee ?? 0} $currency
       Total: $totalAmount $currency
       Time: $timestamp
       Balance: $balance $currency
       Doc ID: $docId
     ''';
    }
  }

  bool isValid() {
    if (isReceived()) {
      return amount > 0 && senderName != null;
    } else {
      return amount > 0 && recipientName != null;
    }
  }

  bool operator ==(Object other) {
    if (other is MoMoTransaction) {
      return type == other.type &&
          amount == other.amount &&
          timestamp == other.timestamp;
    }
    return false;
  }

  int get hashCode => Object.hash(
        type,
        amount,
        timestamp,
        userId,
        isReceived() ? senderName : recipientName,
      );

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString(),
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
      'balance': balance,
      'currency': currency,
      'fee': fee,
      'senderName': senderName,
      'senderPhone': senderPhone,
      'transactionId': transactionId,
      'recipientName': recipientName,
      'recipientPhone': recipientPhone,
      'senderId': senderId,
      // 'id': docId,
      'userId': userId,
      'category': category?.toLowerCase(),
    };
  }

  factory MoMoTransaction.fromJson(Map<String, dynamic> json) {
    return MoMoTransaction(
      type: json['type'] == 'TransactionType.RECEIVED'
          ? TransactionType.RECEIVED
          : TransactionType.SENT,
      amount: json['amount'],
      timestamp: DateTime.parse(json['timestamp']),
      balance: json['balance'],
      currency: json['currency'],
      fee: json['fee'],
      senderName: json['senderName'],
      senderPhone: json['senderPhone'],
      transactionId: json['transactionId'],
      recipientName: json['recipientName'],
      recipientPhone: json['recipientPhone'],
      senderId: json['senderId'],
      docId: json['id'],
      userId: json['userId'],
      category: json['category'],
    );
  }

  // Copy with
  MoMoTransaction copyWith({
    TransactionType? type,
    int? amount,
    DateTime? timestamp,
    int? balance,
    String? currency,
    int? fee,
    String? senderName,
    String? senderPhone,
    String? transactionId,
    String? recipientName,
    String? recipientPhone,
    String? senderId,
    String? userId,
    String? category,
  }) {
    return MoMoTransaction(
      type: type ?? this.type,
      amount: amount ?? this.amount,
      timestamp: timestamp ?? this.timestamp,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      fee: fee ?? this.fee,
      senderName: senderName ?? this.senderName,
      senderPhone: senderPhone ?? this.senderPhone,
      transactionId: transactionId ?? this.transactionId,
      recipientName: recipientName ?? this.recipientName,
      recipientPhone: recipientPhone ?? this.recipientPhone,
      senderId: senderId ?? this.senderId,
      userId: userId ?? this.userId,
      category: category ?? this.category,
      docId: docId,
    );
  }
}
