import 'package:flutter_test/flutter_test.dart';
import 'package:xpanse_app/models/m_money.dart';

void main() {
  group('MoMoTransaction Constructor Tests', () {
    test('Creates SENT transaction with required fields', () {
      final transaction = MoMoTransaction(
        type: TransactionType.SENT,
        amount: 5000,
        timestamp: DateTime(2024, 1, 1),
        balance: 95000,
        currency: 'RWF',
        userId: 'test-user',
      );

      expect(transaction.type, TransactionType.SENT);
      expect(transaction.amount, 5000);
      expect(transaction.balance, 95000);
      expect(transaction.currency, 'RWF');
      expect(transaction.userId, 'test-user');
      expect(transaction.fee, isNull);
      expect(transaction.recipientName, isNull);
    });

    test('Creates RECEIVED transaction with required fields', () {
      final transaction = MoMoTransaction(
        type: TransactionType.RECEIVED,
        amount: 3000,
        timestamp: DateTime(2024, 1, 1),
        balance: 98000,
        currency: 'RWF',
        userId: 'test-user',
      );

      expect(transaction.type, TransactionType.RECEIVED);
      expect(transaction.amount, 3000);
      expect(transaction.senderName, isNull);
      expect(transaction.transactionId, isNull);
    });
  });

  group('JSON Serialization Tests', () {
    test('toJson converts SENT transaction correctly', () {
      final transaction = MoMoTransaction(
        type: TransactionType.SENT,
        amount: 5000,
        timestamp: DateTime(2024, 1, 1),
        balance: 95000,
        currency: 'RWF',
        userId: 'test-user',
        fee: 100,
        recipientName: 'John Doe',
        recipientPhone: '1234567890',
        category: 'Food',
      );

      final json = transaction.toJson();

      expect(json['type'], 'TransactionType.SENT');
      expect(json['amount'], 5000);
      expect(json['balance'], 95000);
      expect(json['currency'], 'RWF');
      expect(json['fee'], 100);
      expect(json['recipientName'], 'John Doe');
      expect(json['recipientPhone'], '1234567890');
      expect(json['category'], 'food');
    });

    test('fromJson creates RECEIVED transaction correctly', () {
      final json = {
        'type': 'TransactionType.RECEIVED',
        'amount': 3000,
        'timestamp': '2024-01-01T00:00:00.000',
        'balance': 98000,
        'currency': 'RWF',
        'senderName': 'Jane Doe',
        'senderPhone': '0987654321',
        'transactionId': 'trans123',
        'userId': 'test-user',
        'category': 'Income',
      };

      final transaction = MoMoTransaction.fromJson(json);

      expect(transaction.type, TransactionType.RECEIVED);
      expect(transaction.amount, 3000);
      expect(transaction.senderName, 'Jane Doe');
      expect(transaction.senderPhone, '0987654321');
      expect(transaction.transactionId, 'trans123');
      expect(transaction.category, 'Income');
    });

    test('JSON serialization maintains data integrity', () {
      final original = MoMoTransaction(
        type: TransactionType.SENT,
        amount: 5000,
        timestamp: DateTime(2024, 1, 1),
        balance: 95000,
        currency: 'RWF',
        userId: 'test-user',
        fee: 100,
        recipientName: 'John Doe',
        category: 'Food',
      );

      final json = original.toJson();
      final recreated = MoMoTransaction.fromJson(json);

      expect(recreated.type, original.type);
      expect(recreated.amount, original.amount);
      expect(recreated.balance, original.balance);
      expect(recreated.currency, original.currency);
      expect(recreated.fee, original.fee);
      expect(recreated.recipientName, original.recipientName);
      expect(recreated.category, original.category);
    });
  });

  group('Helper Method Tests', () {
    test('isReceived returns correct boolean', () {
      final received = MoMoTransaction(
        type: TransactionType.RECEIVED,
        amount: 3000,
        timestamp: DateTime.now(),
        balance: 98000,
        currency: 'RWF',
        userId: 'test-user',
      );

      final sent = MoMoTransaction(
        type: TransactionType.SENT,
        amount: 5000,
        timestamp: DateTime.now(),
        balance: 95000,
        currency: 'RWF',
        userId: 'test-user',
      );

      expect(received.isReceived(), true);
      expect(sent.isReceived(), false);
    });

    test('isSent returns correct boolean', () {
      final received = MoMoTransaction(
        type: TransactionType.RECEIVED,
        amount: 3000,
        timestamp: DateTime.now(),
        balance: 98000,
        currency: 'RWF',
        userId: 'test-user',
      );

      final sent = MoMoTransaction(
        type: TransactionType.SENT,
        amount: 5000,
        timestamp: DateTime.now(),
        balance: 95000,
        currency: 'RWF',
        userId: 'test-user',
      );

      expect(received.isSent(), false);
      expect(sent.isSent(), true);
    });

    test('totalAmount includes fee for sent transactions', () {
      final transaction = MoMoTransaction(
        type: TransactionType.SENT,
        amount: 5000,
        timestamp: DateTime.now(),
        balance: 95000,
        currency: 'RWF',
        userId: 'test-user',
        fee: 100,
      );

      expect(transaction.totalAmount, 5100);
    });

    test('isValid returns correct validation status', () {
      final validReceived = MoMoTransaction(
        type: TransactionType.RECEIVED,
        amount: 3000,
        timestamp: DateTime.now(),
        balance: 98000,
        currency: 'RWF',
        userId: 'test-user',
        senderName: 'John Doe',
      );

      final invalidReceived = MoMoTransaction(
        type: TransactionType.RECEIVED,
        amount: 0,
        timestamp: DateTime.now(),
        balance: 98000,
        currency: 'RWF',
        userId: 'test-user',
      );

      final validSent = MoMoTransaction(
        type: TransactionType.SENT,
        amount: 5000,
        timestamp: DateTime.now(),
        balance: 95000,
        currency: 'RWF',
        userId: 'test-user',
        recipientName: 'Jane Doe',
      );

      expect(validReceived.isValid(), true);
      expect(invalidReceived.isValid(), false);
      expect(validSent.isValid(), true);
    });
  });

  group('Equality and Hash Tests', () {
    test('Equal transactions have same hash code', () {
      final timestamp = DateTime(2024, 1, 1);
      final transaction1 = MoMoTransaction(
        type: TransactionType.SENT,
        amount: 5000,
        timestamp: timestamp,
        balance: 95000,
        currency: 'RWF',
        userId: 'test-user',
      );

      final transaction2 = MoMoTransaction(
        type: TransactionType.SENT,
        amount: 5000,
        timestamp: timestamp,
        balance: 95000,
        currency: 'RWF',
        userId: 'test-user',
      );

      expect(transaction1 == transaction2, true);
      expect(transaction1.hashCode == transaction2.hashCode, true);
    });
  });

  group('CopyWith Tests', () {
    test('copyWith creates new instance with updated fields', () {
      final original = MoMoTransaction(
        type: TransactionType.SENT,
        amount: 5000,
        timestamp: DateTime(2024, 1, 1),
        balance: 95000,
        currency: 'RWF',
        userId: 'test-user',
      );

      final copied = original.copyWith(
        amount: 6000,
        category: 'Food',
      );

      expect(copied.amount, 6000);
      expect(copied.category, 'Food');
      expect(copied.type, original.type);
      expect(copied.timestamp, original.timestamp);
    });
  });
}
