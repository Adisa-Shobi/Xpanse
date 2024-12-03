import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xpanse_app/services/user.dart';

void main() {
  group('UserMetaData Tests', () {
    final DateTime testDate = DateTime(2024, 1, 1);
    final timestamp = Timestamp.fromDate(testDate);

    test('Creating UserMetaData instance with required fields', () {
      final userData = UserMetaData(
        uid: 'test-uid',
        email: 'test@example.com',
        firstName: 'John',
        lastName: 'Doe',
        displayName: 'John Doe',
        status: 'active',
        userType: 'email',
        createdAt: testDate,
        lastLogin: testDate,
      );

      expect(userData.uid, 'test-uid');
      expect(userData.email, 'test@example.com');
      expect(userData.firstName, 'John');
      expect(userData.lastName, 'Doe');
      expect(userData.displayName, 'John Doe');
      expect(userData.status, 'active');
      expect(userData.userType, 'email');
      expect(userData.createdAt, testDate);
      expect(userData.lastLogin, testDate);
    });

    test('fromMap creates UserMetaData with complete data', () {
      final Map<String, dynamic> testMap = {
        'uid': 'test-uid',
        'email': 'test@example.com',
        'firstName': 'John',
        'lastName': 'Doe',
        'displayName': 'John Doe',
        'status': 'active',
        'userType': 'email',
        'createdAt': timestamp,
        'lastLogin': timestamp,
      };

      final userData = UserMetaData.fromMap(testMap);

      expect(userData.uid, 'test-uid');
      expect(userData.email, 'test@example.com');
      expect(userData.firstName, 'John');
      expect(userData.lastName, 'Doe');
      expect(userData.displayName, 'John Doe');
      expect(userData.status, 'active');
      expect(userData.userType, 'email');
      expect(userData.createdAt, testDate);
      expect(userData.lastLogin, testDate);
    });

    test('fromMap handles missing optional fields with defaults', () {
      final Map<String, dynamic> incompleteMap = {
        'uid': 'test-uid',
        'email': 'test@example.com',
        'createdAt': timestamp,
        'lastLogin': timestamp,
      };

      final userData = UserMetaData.fromMap(incompleteMap);

      expect(userData.firstName, '');
      expect(userData.lastName, '');
      expect(userData.displayName, '');
      expect(userData.status, 'active');
      expect(userData.userType, 'email');
    });

    test('toMap converts UserMetaData to Map correctly', () {
      final userData = UserMetaData(
        uid: 'test-uid',
        email: 'test@example.com',
        firstName: 'John',
        lastName: 'Doe',
        displayName: 'John Doe',
        status: 'active',
        userType: 'email',
        createdAt: testDate,
        lastLogin: testDate,
      );

      final map = userData.toMap();

      expect(map['uid'], 'test-uid');
      expect(map['email'], 'test@example.com');
      expect(map['firstName'], 'John');
      expect(map['lastName'], 'Doe');
      expect(map['displayName'], 'John Doe');
      expect(map['status'], 'active');
      expect(map['userType'], 'email');
      expect(map['createdAt'], isA<Timestamp>());
      expect((map['createdAt'] as Timestamp).toDate(), testDate);
      expect(map['lastLogin'], isA<Timestamp>());
      expect((map['lastLogin'] as Timestamp).toDate(), testDate);
    });

    test('fromMap and toMap maintain data integrity', () {
      final initialMap = {
        'uid': 'test-uid',
        'email': 'test@example.com',
        'firstName': 'John',
        'lastName': 'Doe',
        'displayName': 'John Doe',
        'status': 'active',
        'userType': 'email',
        'createdAt': timestamp,
        'lastLogin': timestamp,
      };

      final userData = UserMetaData.fromMap(initialMap);
      final resultMap = userData.toMap();

      expect(resultMap['uid'], initialMap['uid']);
      expect(resultMap['email'], initialMap['email']);
      expect(resultMap['firstName'], initialMap['firstName']);
      expect(resultMap['lastName'], initialMap['lastName']);
      expect(resultMap['displayName'], initialMap['displayName']);
      expect(resultMap['status'], initialMap['status']);
      expect(resultMap['userType'], initialMap['userType']);
      expect((resultMap['createdAt'] as Timestamp).toDate(),
          (initialMap['createdAt'] as Timestamp).toDate());
      expect((resultMap['lastLogin'] as Timestamp).toDate(),
          (initialMap['lastLogin'] as Timestamp).toDate());
    });
  });
}
