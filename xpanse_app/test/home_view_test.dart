import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:xpanse_app/controllers/home_controller.dart';
import 'package:xpanse_app/models/m_money.dart';
import 'package:xpanse_app/services/user.dart';
import 'package:xpanse_app/services/user_data.dart';
import 'package:xpanse_app/views/home/views/home_view.dart';

import 'mock.dart'; // Assuming you have mock data

void main() {
  late HomeController controller;

  setUpAll(() {
    Get.testMode = true;
  });

  setUp(() {
    setupFirebaseAuthMocks();
    controller = HomeController();
    Get.put(controller);

    // Set up mock data
    controller.userData.value = UserData(
      startWeek: 1,
      startMonth: 1,
      budget: 100000,
    );

    controller.userMetaData.value = UserMetaData(
      uid: 'test-user-id',
      email: 'testuser@email.com',
      firstName: 'John',
      lastName: 'Doe',
      displayName: 'John Doe',
      status: 'active',
      userType: 'email',
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
    );

    // Create mock transactions using the proper model
    controller.transactions.assignAll([
      MoMoTransaction(
        type: TransactionType.SENT,
        amount: 5000,
        timestamp: DateTime.now(),
        balance: 95000,
        currency: 'RWF',
        userId: 'test-user-id',
        recipientName: 'Test Recipient',
        recipientPhone: '+250789123456',
        category: 'Food',
        fee: 100,
      ),
      MoMoTransaction(
        type: TransactionType.RECEIVED,
        amount: 3000,
        timestamp: DateTime.now(),
        balance: 98000,
        currency: 'RWF',
        userId: 'test-user-id',
        senderName: 'Test Sender',
        senderPhone: '+250789123457',
        category: 'Income',
        transactionId: 'test-transaction-id',
      ),
    ]);

    controller.monthlyExenditure.value = 8000;
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('HomeView displays loading indicator when userData is null',
      (WidgetTester tester) async {
    controller.userData.value = null;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: HomeView(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('HomeView displays correct budget information',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: HomeView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Targeted Budget'), findsOneWidget);
    expect(find.text('Rwf 100,000'), findsOneWidget);
    expect(find.text("This Motnh's Budget"), findsOneWidget);
    expect(find.text('Rwf 8,000 of Rwf 100,000'), findsOneWidget);
  });

  testWidgets('HomeView displays greeting with user name',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: HomeView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Good Morning, John'), findsOneWidget);
  });

  group('Transaction List Tests', () {
    testWidgets('HomeView displays transaction list correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HomeView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Recent Expenses'), findsOneWidget);
      expect(find.byType(ExpenseItem), findsNWidgets(2));
      expect(find.text('Test Recipient'), findsOneWidget);
      expect(find.text('Test Sender'), findsOneWidget);
      expect(find.text('Rwf 5,000'), findsOneWidget);
      expect(find.text('Rwf 3,000'), findsOneWidget);
    });

    testWidgets('ExpenseItem shows correct transaction details',
        (WidgetTester tester) async {
      final transaction = MoMoTransaction(
        type: TransactionType.SENT,
        amount: 5000,
        timestamp: DateTime.now(),
        balance: 95000,
        currency: 'RWF',
        userId: 'test-user-id',
        recipientName: 'Test Recipient',
        recipientPhone: '+250789123456',
        category: 'Food',
        fee: 100,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpenseItem(transaction: transaction),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test Recipient'), findsOneWidget);
      expect(find.text('Rwf 5,000'), findsOneWidget);
    });
  });

  group('Budget Update Tests', () {
    testWidgets('Budget bottom sheet appears and validates input',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HomeView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Set'));
      await tester.pumpAndSettle();

      expect(find.text('Set Budget'), findsNWidgets(2)); // Title and label
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);

      // Test validation
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(find.text('Please enter a value'), findsOneWidget);

      // Test invalid input
      await tester.enterText(find.byType(TextFormField), 'invalid');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(find.text('Please enter a valid number'), findsOneWidget);
    });
  });
}
