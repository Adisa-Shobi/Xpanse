import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:xpanse_app/controllers/home_controller.dart';
import 'package:xpanse_app/models/m_money.dart';
import 'package:xpanse_app/services/categories.dart';
import 'package:xpanse_app/services/user_data.dart';
import 'package:xpanse_app/views/home/views/expense_view.dart';

void main() {
  late HomeController controller;

  setUp(() {
    Get.testMode = true;
    controller = HomeController();
    Get.put(controller);

    // Mock data
    controller.userData.value = UserData(
      startWeek: 1,
      startMonth: 1,
      budget: 100000,
    );

    controller.balance.value = 75000;

    controller.categories.assignAll([
      Category(
        id: '1',
        name: 'food',
        userId: 'test-user',
        icon: 'restaurant',
        createdAt: DateTime.now(),
      ),
      Category(
        id: '2',
        name: 'transport',
        userId: 'test-user',
        icon: 'directions_car',
        createdAt: DateTime.now(),
      ),
    ]);

    controller.transactions.assignAll([
      MoMoTransaction(
        type: TransactionType.SENT,
        amount: 5000,
        timestamp: DateTime.now(),
        balance: 95000,
        currency: 'RWF',
        userId: 'test-user',
        category: 'food',
      ),
      MoMoTransaction(
        type: TransactionType.SENT,
        amount: 3000,
        timestamp: DateTime.now(),
        balance: 92000,
        currency: 'RWF',
        userId: 'test-user',
        category: 'transport',
      ),
    ]);

    controller.monthlyExenditure.value = 8000;
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('ExpensesView displays all major sections',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExpensesView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Check heading
    expect(find.text('Expenses Overview'), findsOneWidget);

    // Check budget cards
    expect(find.text('This Month Budget'), findsOneWidget);
    expect(find.text('Available Balance'), findsOneWidget);
    expect(find.text('Rwf 100,000'), findsOneWidget);
    expect(find.text('Rwf 75,000'), findsOneWidget);

    // Check expenses section
    expect(find.text('Set Expenses'), findsOneWidget);
    expect(find.text('New Category'), findsOneWidget);
  });

  group('Budget Cards Tests', () {
    testWidgets('Budget cards show correct values',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpensesView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Rwf 100,000'), findsOneWidget);
      expect(find.text('Rwf 75,000'), findsOneWidget);
    });
  });

  group('Category Section Tests', () {
    testWidgets('Shows existing categories', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpensesView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Food'), findsOneWidget);
      expect(find.text('Transport'), findsOneWidget);
    });

    testWidgets('New Category button shows bottom sheet',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpensesView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('New Category'));
      await tester.pumpAndSettle();

      expect(find.text('Create Category'), findsOneWidget);
      expect(find.text('Category Name'), findsOneWidget);
      expect(find.text('Create'), findsOneWidget);
    });
  });

  group('Expenses Overview Tests', () {
    testWidgets('Shows correct percentage for categories',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpensesView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Calculate expected percentages based on transactions
      expect(find.text('62.5%'), findsOneWidget); // 5000/8000 * 100
      expect(find.text('37.5%'), findsOneWidget); // 3000/8000 * 100
    });

    testWidgets('Shows circular progress indicators',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpensesView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });
  });

  group('Category Card Grid Tests', () {
    testWidgets('Shows correct number of category cards',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpensesView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Count cards (categories + Others)
      expect(find.byType(GridView), findsOneWidget);
      expect(find.text('Others'), findsOneWidget);
    });

    testWidgets('Category cards show correct amounts',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpensesView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Rwf 5,000'), findsOneWidget); // Food category
      expect(find.text('Rwf 3,000'), findsOneWidget); // Transport category
    });
  });
}
