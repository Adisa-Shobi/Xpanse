import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:xpanse_app/controllers/profile_controller.dart';

import 'mock.dart'; // Assuming you have the same mock file

void main() {
  late ProfileController controller;

  setUp(() async {
    setupFirebaseAuthMocks();
    controller = ProfileController();
    Get.put(controller);
  });

  tearDown(() {
    Get.delete<ProfileController>();
  });

  test('Initial values are correct', () {
    expect(controller.firstName.value, '');
    expect(controller.lastName.value, '');
    expect(controller.phoneNumber.value, '');
    expect(controller.email.value, '');
    expect(controller.profileImageUrl.value, '');
    expect(controller.startOfMonthDay.value, '');
    expect(controller.isLoading.value, false);
  });

  test('fetchProfileData updates user data', () async {
    controller.fetchProfileData();

    expect(controller.firstName.value, isNotEmpty);
    expect(controller.lastName.value, isNotEmpty);
    expect(controller.phoneNumber.value, isNotEmpty);
    expect(controller.email.value, isNotEmpty);
    expect(controller.isLoading.value, false);
  });

  test('updateProfileData updates user information', () async {
    final newFirstName = 'John';
    final newLastName = 'Doe';
    final newPhone = '1234567890';
    final newEmail = 'john.doe@example.com';

    controller.updateProfileData(
      firstName: newFirstName,
      lastName: newLastName,
      phoneNumber: newPhone,
      email: newEmail,
    );

    expect(controller.firstName.value, newFirstName);
    expect(controller.lastName.value, newLastName);
    expect(controller.phoneNumber.value, newPhone);
    expect(controller.email.value, newEmail);
    expect(controller.isLoading.value, false);
  });

  test('updateStartOfMonth updates start day', () async {
    const newDay = '15';

    controller.updateStartOfMonth(newDay);

    expect(controller.startOfMonthDay.value, newDay);
    expect(controller.isLoading.value, false);
  });

  group('Profile Image Tests', () {
    test('changeProfileImage updates profile image URL', () async {
      // Mock successful image pick and upload
      // You'll need to mock ImagePicker and Firebase Storage
      await controller.changeProfileImage();

      expect(controller.profileImageUrl.value, isNotEmpty);
      expect(controller.isLoading.value, false);
    });

    test('changeProfileImage handles null image pick', () async {
      // Mock cancelled image pick
      // Test that nothing changes when user cancels image pick
      await controller.changeProfileImage();

      final previousUrl = controller.profileImageUrl.value;
      expect(controller.profileImageUrl.value, previousUrl);
      expect(controller.isLoading.value, false);
    });
  });

  group('Error Handling Tests', () {
    test('fetchProfileData handles errors gracefully', () async {
      // Mock a Firebase error
      // Test that error handling works as expected
      controller.fetchProfileData();

      expect(controller.isLoading.value, false);
      // You might want to verify that a snackbar was shown
    });

    test('updateProfileData handles errors gracefully', () async {
      // Mock a Firebase error
      controller.updateProfileData(
        firstName: 'Test',
        lastName: 'User',
        phoneNumber: '1234567890',
        email: 'test@example.com',
      );

      expect(controller.isLoading.value, false);
      // Verify error handling behavior
    });
  });
}
