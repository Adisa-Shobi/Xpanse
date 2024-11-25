import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference _user =
      FirebaseFirestore.instance.collection('users');

  // GET - Get user info bu userId
  Future<UserMetaData> getUser(String uid) async {
    try {
      DocumentSnapshot doc = await _user.doc(uid).get();
      if (!doc.exists) {
        throw Exception('User not found');
      }
      return UserMetaData.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }
}

class UserMetaData {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String displayName;
  final String status;
  final String userType;
  final DateTime createdAt;
  final DateTime lastLogin;

  UserMetaData({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.displayName,
    required this.status,
    required this.userType,
    required this.createdAt,
    required this.lastLogin,
  });

  factory UserMetaData.fromMap(Map<String, dynamic> map) {
    return UserMetaData(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      displayName: map['displayName'] ?? '',
      status: map['status'] ?? 'active',
      userType: map['userType'] ?? 'email',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      lastLogin: (map['lastLogin'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'displayName': displayName,
      'status': status,
      'userType': userType,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': Timestamp.fromDate(lastLogin),
    };
  }
}
