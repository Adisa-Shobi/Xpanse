import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataService {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users_data');

  // CREATE - Create user data
  Future<void> createUserData(String userId, UserData userData) async {
    try {
      await _users.doc(userId).set(userData.toFirestore());
    } catch (e) {
      throw Exception('Failed to create user data: $e');
    }
  }

// GET - Get user data
  Future<UserData?> getUserData(String userId) async {
    try {
      DocumentSnapshot doc = await _users.doc(userId).get();
      if (doc.exists) {
        return UserData.fromFirestore(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user data: $e');
    }
  }

// READ - Stream user data (real-time updates)
  Stream<UserData?> streamUserData(String userId) {
    return _users.doc(userId).snapshots().map((doc) {
      if (doc.exists) {
        return UserData.fromFirestore(doc.data() as Map<String, dynamic>);
      }
      return null;
    });
  }

  // UPDATE - Update user data
  Future<void> updateUserData(String userId, UserData userData) async {
    try {
      await _users.doc(userId).update(userData.toFirestore());
    } catch (e) {
      throw Exception('Failed to update user data: $e');
    }
  }

  // DELETE - Delete user data
  Future<void> deleteUserData(String userId) async {
    try {
      await _users.doc(userId).delete();
    } catch (e) {
      throw Exception('Failed to delete user data: $e');
    }
  }

  // Check if user data exists
  Future<bool> userDataExists(String userId) async {
    try {
      DocumentSnapshot doc = await _users.doc(userId).get();
      return doc.exists;
    } catch (e) {
      throw Exception('Failed to check user data: $e');
    }
  }

  // Get or create user data
  Future<UserData> getOrCreateUserData(String userId, UserData data) async {
    try {
      DocumentSnapshot doc = await _users.doc(userId).get();

      if (!doc.exists) {
        await createUserData(userId, data);
        return data;
      }

      return UserData.fromFirestore(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get or create user data: $e');
    }
  }
}

// Usage Examples:
// void main() async {
//  final userService = UserDataService();
//  final String userId = 'user123';

//  // Create user data
//  await userService.createUserData(
//    userId: userId,
//    startDay: 1,
//    startMonth: 1,
//    budget: 5000.0,
//  );

//  // Read user data
//  final userData = await userService.getUserData(userId);
//  print('User Data: $userData');

//  // Update user data
//  await userService.updateUserData(
//    userId: userId,
//    budget: 6000.0,
//  );

//  // Stream usage in Flutter
//  StreamBuilder<Map<String, dynamic>?>(
//    stream: userService.streamUserData(userId),
//    builder: (context, snapshot) {
//      if (snapshot.hasError) {
//        return Text('Error: ${snapshot.error}');
//      }

//      if (snapshot.connectionState == ConnectionState.waiting) {
//        return CircularProgressIndicator();
//      }

//      if (!snapshot.hasData) {
//        return Text('No user data found');
//      }

//      final userData = snapshot.data!;
//      return Column(
//        children: [
//          Text('Start Day: ${userData['startDay']}'),
//          Text('Start Month: ${userData['startMonth']}'),
//          Text('Budget: ${userData['budget']}'),
//        ],
//      );
//    },
//  );

//  // Get or create user data
//  final userDataWithDefaults = await userService.getOrCreateUserData(
//    userId: userId,
//    defaultStartDay: 1,
//    defaultStartMonth: 1,
//    defaultBudget: 5000.0,
//  );
// }

// User Data Model (Optional but recommended)
class UserData {
  final int startWeek;
  final int startMonth;
  final int budget;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserData({
    required this.startWeek,
    required this.startMonth,
    required this.budget,
    this.createdAt,
    this.updatedAt,
  });

  // Convert from Firebase document
  factory UserData.fromFirestore(Map<String, dynamic> doc) {
    return UserData(
      startWeek: doc['startWeek'] as int,
      startMonth: doc['startMonth'] as int,
      budget: (doc['budget'] as num).toInt(),
      createdAt: (doc['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (doc['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  // Convert to Firebase document
  Map<String, dynamic> toFirestore() {
    return {
      'startWeek': startWeek,
      'startMonth': startMonth,
      'budget': budget,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  // Copy with method for updates
  UserData copyWith({
    int? startWeek,
    int? startMonth,
    int? budget,
  }) {
    return UserData(
      startWeek: startWeek ?? this.startWeek,
      startMonth: startMonth ?? this.startMonth,
      budget: budget ?? this.budget,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
