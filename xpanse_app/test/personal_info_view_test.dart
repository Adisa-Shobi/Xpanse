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

    // Initialize with empty data
    controller.userData.value = UserData(
      startWeek: 1,
      startMonth: 1,
      budget: 0,
    );
    controller.balance.value = 0;
    controller.categories.clear();
    controller.transactions.clear();
    controller.monthlyExenditure.value = 0;
  });

  tearDown(() {
    Get.reset();
  });

  group('Empty State Tests', () {
    testWidgets('Shows zero values when no data is present',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpensesView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Rwf 0'), findsWidgets);
      expect(find.text('Others'), findsOneWidget);
    });
  });

  group('Category Creation Flow', () {
    testWidgets('Can create new category with validation',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpensesView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Open bottom sheet
      await tester.tap(find.text('New Category'));
      await tester.pumpAndSettle();

      // Try to submit empty form
      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();
      expect(find.text('Please enter a value'), findsOneWidget);

      // Enter category name
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Category Name'), 'Entertainment');
      await tester.pumpAndSettle();

      // Submit form
      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      // Verify category was added
      expect(find.text('Entertainment'), findsOneWidget);
    });
  });

  group('Transaction Filtering Tests', () {
    setUp(() {
      // Add transactions from different months
      final currentMonth = DateTime.now();
      final lastMonth =
          DateTime(currentMonth.year, currentMonth.month - 1, currentMonth.day);

      controller.transactions.assignAll([
        MoMoTransaction(
          type: TransactionType.SENT,
          amount: 5000,
          timestamp: currentMonth,
          balance: 95000,
          currency: 'RWF',
          userId: 'test-user',
          category: 'food',
        ),
        MoMoTransaction(
          type: TransactionType.SENT,
          amount: 3000,
          timestamp: lastMonth,
          balance: 92000,
          currency: 'RWF',
          userId: 'test-user',
          category: 'food',
        ),
      ]);

      controller.monthlyExenditure.value = 5000; // Only current month
    });

    testWidgets('Only shows current month transactions in overview',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpensesView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Rwf 5,000'), findsOneWidget);
      expect(
          find.text('100.0%'), findsOneWidget); // All expenses in one category
    });
  });

  group('UI Interaction Tests', () {
    testWidgets('Scrolls properly with many categories',
        (WidgetTester tester) async {
      // Add many categories
      controller.categories.assignAll(
        List.generate(
          10,
          (index) => Category(
            id: index.toString(),
            name: 'Category $index',
            userId: 'test-user',
            icon: 'home',
            createdAt: DateTime.now(),
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpensesView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Check if we can scroll
      await tester.dragFrom(const Offset(0, 300), const Offset(0, -300));
      await tester.pumpAndSettle();

      // Verify that we can see items after scrolling
      expect(find.text('Category 9'), findsOneWidget);
    });

    testWidgets('Category cards respond to different screen sizes',
        (WidgetTester tester) async {
      // Set up some categories
      controller.categories.assignAll([
        Category(
          id: '1',
          name: 'Food',
          userId: 'test-user',
          icon: 'restaurant',
          createdAt: DateTime.now(),
        ),
        Category(
          id: '2',
          name: 'Transport',
          userId: 'test-user',
          icon: 'directions_car',
          createdAt: DateTime.now(),
        ),
      ]);

      // Test in different screen sizes
      await tester.binding.setSurfaceSize(const Size(300, 600)); // Small screen
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpensesView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final smallScreenGridView = find.byType(GridView);
      expect(smallScreenGridView, findsOneWidget);

      // Test larger screen
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpensesView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final largeScreenGridView = find.byType(GridView);
      expect(largeScreenGridView, findsOneWidget);
    });
  });

  group('Error Handling Tests', () {
    testWidgets('Handles null category icons gracefully',
        (WidgetTester tester) async {
      controller.categories.add(Category(
        id: '1',
        name: 'Invalid Icon',
        userId: 'test-user',
        icon: 'invalid_icon',
        createdAt: DateTime.now(),
      ));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpensesView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Should show fallback icon
      expect(find.byIcon(Icons.cancel), findsOneWidget);
    });
  });
}
