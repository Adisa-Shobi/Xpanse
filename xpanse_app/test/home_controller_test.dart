import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:xpanse_app/controllers/home_controller.dart';
import 'package:xpanse_app/models/m_money.dart';
import 'package:xpanse_app/services/categories.dart';
import 'package:xpanse_app/services/user_data.dart';

import 'mock.dart';

void main() {
  late HomeController controller;

  setUp(() async {
    setupFirebaseAuthMocks();
    controller = HomeController();
    Get.put(controller);
  });

  tearDown(() {
    Get.delete<HomeController>();
  });

  test('Initial values are correct', () {
    expect(controller.currentIndex.value, 0);
    expect(controller.balance.value, 0);
    expect(controller.userData.value, null);
    expect(controller.userMetaData.value, null);
    expect(controller.monthlyExenditure.value, 0);
    expect(controller.transactions, isEmpty);
    expect(controller.categories, isEmpty);
  });

  test('changeIndex updates currentIndex', () {
    controller.changeIndex(2);
    expect(controller.currentIndex.value, 2);
  });

  test('loadUserData sets userData', () async {
    controller.loadUserData();
    expect(controller.userData.value, isNotNull);
  });

  test('updateUserData updates userData', () async {
    final newData = UserData(startWeek: 1, startMonth: 2, budget: 2000000);
    await controller.updateUserData(newData);
    expect(controller.userData.value, newData);
  });

  test('createCategory adds category', () async {
    final category =
        Category(name: 'Test Category', userId: controller.user.value.uid);
    await controller.createCategory(category);
    expect(controller.categories, contains(category));
  });

  test('updateTransaction updates transaction', () async {
    MoMoTransaction transaction = controller.transactions.first;
    final newTransaction = transaction.copyWith(category: 'Updated Category');
    await controller.updateTransaction(newTransaction);
    expect(controller.transactions.first.category, 'Updated Category');
  });
}
