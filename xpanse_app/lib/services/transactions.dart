// Firebase CRUD Operations Example

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xpanse_app/models/m_money.dart';

class TransactionService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('transactions');

  // CREATE - Add a new document
  Future<void> createTransaction(MoMoTransaction data) async {
    try {
      await _collection.add({
        ...data.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to create transaction: $e');
    }
  }

  // READ - Get a single document
  Future<Map<String, dynamic>?> getTransaction(String id) async {
    try {
      DocumentSnapshot doc = await _collection.doc(id).get();
      return doc.exists ? doc.data() as Map<String, dynamic> : null;
    } catch (e) {
      throw Exception('Failed to get transaction: $e');
    }
  }

  // READ - Get all documents
  Future<List<MoMoTransaction>> getAllTransactions(
    String userId, {
    int limit = 10,
    DocumentSnapshot? lastDocument,
  } // Change offset to lastDocument
      ) async {
    try {
      Query query = _collection
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      QuerySnapshot querySnapshot = await query.get();

      return querySnapshot.docs
          .map((doc) => MoMoTransaction.fromJson({
                'id': doc.id,
                ...doc.data() as Map<String, dynamic>,
              }))
          .toList();
    } catch (e) {
      throw Exception('Failed to get transactions: $e');
    }
  }

  // READ - With queries
  Future<List<Map<String, dynamic>>> getFilteredTransactions({
    required String field,
    required dynamic value,
  }) async {
    try {
      QuerySnapshot querySnapshot =
          await _collection.where(field, isEqualTo: value).get();

      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      throw Exception('Failed to get filtered transactions: $e');
    }
  }

  // DELETE - Delete a document
  Future<void> deleteTransaction(String id) async {
    try {
      await _collection.doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete transaction: $e');
    }
  }

  // Batch Write Example
  Future<void> batchWrite(List<MoMoTransaction> transactions) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    try {
      for (var transaction in transactions) {
        DocumentReference docRef = _collection.doc();
        batch.set(docRef, {
          ...transaction.toJson(),
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to batch write: $e');
    }
  }

  Future<MoMoTransaction> getLastTransaction(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _collection
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      return MoMoTransaction.fromJson(
          querySnapshot.docs.first.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get last transaction: $e');
    }
  }

  Future<void> syncTransactions(
      List<MoMoTransaction> transactions, String userId) async {
    try {
      final lastTransaction = await getLastTransaction(userId);

      final newTransactions = transactions
          .where((t) => t.timestamp.isAfter(lastTransaction.timestamp))
          .toList();
      await batchWrite(newTransactions);
    } catch (e) {
      await batchWrite(transactions);
      return;
    }
  }

  // Get total expenditure for a specific month
  Future<double> getMonthlyExpenditure(
    int month,
    int year, {
    required String userId,
  }) async {
    try {
      // Get start and end date for the month
      final startDate = DateTime(year, month, 1);
      final endDate = DateTime(year, month + 1, 0); // Last day of month

      final snapshot = await _collection
          .where('userId', isEqualTo: userId)
          .where(
            'type',
            isEqualTo: TransactionType.SENT.toString(),
          ) // Only get expenses/debits
          .where('timestamp',
              isGreaterThanOrEqualTo: startDate.toIso8601String())
          .where('timestamp', isLessThanOrEqualTo: endDate.toIso8601String())
          .get();

      double total = 0;
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        total += data['amount'] as int;
      }

      return total;
    } catch (e) {
      throw Exception('Failed to get monthly expenditure: $e');
    }
  }

  // Get total expenditure for current month
  Future<double> getCurrentMonthExpenditure({required String userId}) async {
    final now = DateTime.now();
    return getMonthlyExpenditure(now.month, now.year, userId: userId);
  }

  // Get expenditure with budget percentage
  Future<Map<String, dynamic>> getMonthlyExpenditureWithBudget(
    double budget, {
    required String userId,
  }) async {
    final expenditure = await getCurrentMonthExpenditure(userId: userId);
    final percentage = (expenditure / budget) * 100;

    return {
      'expenditure': expenditure,
      'budget': budget,
      'percentage': percentage,
      'remaining': budget - expenditure
    };
  }

  // Get expenditure between dates (for custom periods)
  Future<double> getExpenditureBetweenDates(
    DateTime startDate,
    DateTime endDate, {
    required String userId,
  }) async {
    try {
      final snapshot = await _collection
          .where('userId', isEqualTo: userId)
          .where('type', isEqualTo: 'SENT')
          .where('timestamp', isGreaterThanOrEqualTo: startDate)
          .where('timestamp', isLessThanOrEqualTo: endDate)
          .get();

      double total = 0;
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        total += data['amount'] as double;
      }

      return total;
    } catch (e) {
      throw Exception('Failed to get expenditure between dates: $e');
    }
  }
}

// Usage Examples:

// void main() async {
//   final firebaseService = FirebaseService();

//   // Create
//   await firebaseService.createTransaction({
//     'amount': 1000,
//     'type': 'RECEIVED',
//     'sender': 'John Doe',
//   });

//   // Read
//   final transaction = await firebaseService.getTransaction('transactionId');
//   print(transaction);

//   // Update
//   await firebaseService.updateTransaction('transactionId', {
//     'amount': 2000,
//   });

//   // Delete
//   await firebaseService.deleteTransaction('transactionId');

//   // Stream Usage in Flutter
//   StreamBuilder<List<Map<String, dynamic>>>(
//     stream: firebaseService.streamTransactions(),
//     builder: (context, snapshot) {
//       if (snapshot.hasError) {
//         return Text('Error: ${snapshot.error}');
//       }

//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return CircularProgressIndicator();
//       }

//       final transactions = snapshot.data!;
//       return ListView.builder(
//         itemCount: transactions.length,
//         itemBuilder: (context, index) {
//           final transaction = transactions[index];
//           return ListTile(
//             title: Text('Amount: ${transaction['amount']}'),
//             subtitle: Text('Type: ${transaction['type']}'),
//           );
//         },
//       );
//     },
//   );

//   // Query Example
//   final receivedTransactions = await firebaseService.getFilteredTransactions(
//     field: 'type',
//     value: 'RECEIVED',
//   );
//   print(receivedTransactions);
// }

// Advanced Query Examples

